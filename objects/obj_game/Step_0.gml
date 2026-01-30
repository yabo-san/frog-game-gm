// --- Ensure player exists ---
if (!instance_exists(player)) {
    player = instance_create_layer(room_width/2, room_height/2, "Instances", obj_player);
}

// --- Enemy spawning ---
enemy_spawn_timer -= 1;
if (enemy_spawn_timer <= 0) {
    enemy_spawn_timer = enemy_spawn_rate;

    var edge = irandom(3);
    var spawn_x, spawn_y;

    switch(edge) {
        case 0: spawn_x = irandom(room_width); spawn_y = -32; break;
        case 1: spawn_x = irandom(room_width); spawn_y = room_height + 32; break;
        case 2: spawn_x = -32; spawn_y = irandom(room_height); break;
        case 3: spawn_x = room_width + 32; spawn_y = irandom(room_height); break;
    }

    var enemy_type = choose(obj_bee, obj_fly, obj_snail); // safe, must exist
    //var enemy_type = obj_fly; // safe, must exist
    var e = instance_create_layer(spawn_x, spawn_y, "Instances", enemy_type);

    // Assign target safely
    if (instance_exists(player)) {
        e.target_x = player.x;
        e.target_y = player.y;
    } else {
        e.target_x = room_width/2;
        e.target_y = room_height/2;
    }
}

// Get raw mouse position
var mx = device_mouse_x(0);
var my = device_mouse_y(0);

// Clamp to playfield bounds
mouse_clamped_x = clamp(mx, 0, 639);
mouse_clamped_y = clamp(my, 0, 479);

// Force cursor back inside window
if (mx != mouse_clamped_x || my != mouse_clamped_y) {
    window_mouse_set(mouse_clamped_x, mouse_clamped_y);
}


// --- Brush drawing input ---
// Start drawing on right-click press
if (mouse_check_button_pressed(mb_right)) {
    brush_drawing = true;
    ds_list_clear(brush_points);  // Clear previous drawing
    // Add starting point
    ds_list_add(brush_points, mouse_clamped_x, mouse_clamped_y);
}

// Continue drawing while held
if (brush_drawing && mouse_check_button(mb_right)) {
    var last_index = ds_list_size(brush_points) - 2;
    
    if (last_index >= 0) {
        var last_x = brush_points[| last_index];
        var last_y = brush_points[| last_index + 1];
        var dist = point_distance(last_x, last_y, mouse_clamped_x, mouse_clamped_y);
        
        if (dist > 5) {
            ds_list_add(brush_points, mouse_clamped_x, mouse_clamped_y);
            
            var num_points = ds_list_size(brush_points) / 2;
            if (num_points >= 10) {
                // Check if we've circled back to start (primary method)
                var start_x = brush_points[| 0];
                var start_y = brush_points[| 1];
                var current_x = brush_points[| ds_list_size(brush_points) - 2];
                var current_y = brush_points[| ds_list_size(brush_points) - 1];
                var loop_dist = point_distance(start_x, start_y, current_x, current_y);
                
                // ALSO check for intersection (for figure-8s)
                var has_intersection = scr_path_has_intersection(brush_points);
                
                if (loop_dist < 20 || has_intersection) {
                    brush_circles_completed += 1;
                    
                    if (brush_circles_completed < 3) {
                        // First or second circle - create visual slow zone + apply stacks
                        var zone = instance_create_layer(0, 0, "Instances", obj_slow_zone);
                        zone.polygon_points = ds_list_create();
                        ds_list_copy(zone.polygon_points, brush_points);
                        zone.is_freeze_zone = false;  // Green slow zone
                        
                        with (obj_enemy_base) {
                            if (point_in_polygon(x, y, other.brush_points)) {
                                slow_stacks += 1;
                            }
                        }
                    } else {
                        // Third circle - freeze zone (blue)
                        var zone = instance_create_layer(0, 0, "Instances", obj_slow_zone);
                        zone.polygon_points = ds_list_create();
                        ds_list_copy(zone.polygon_points, brush_points);
                        zone.is_freeze_zone = true;  // Blue freeze zone
                        
                        show_debug_message("FREEZE ZONE CREATED!");
                    }
                    
                    ds_list_clear(brush_points);
                }
            }
        }
    } else {
        ds_list_add(brush_points, mouse_clamped_x, mouse_clamped_y);
    }
}


if (brush_drawing && mouse_check_button_released(mb_right)) {
    brush_drawing = false;
    brush_circles_completed = 0;  // ← Reset for next brush session
    ds_list_clear(brush_points);
}