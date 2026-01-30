// --- Fullscreen toggle ---
if (keyboard_check_pressed(ord("F")) && !is_fullscreen) {
    window_set_fullscreen(true);
    is_fullscreen = true;
    window_mouse_set(window_get_width() / 2, window_get_height() / 2);
}

if (keyboard_check_pressed(ord("W")) && is_fullscreen) {
    window_set_fullscreen(false);
    is_fullscreen = false;
}

// --- Mouse handling ---
if (is_fullscreen) {
    var center_x = window_get_width() / 2;
    var center_y = window_get_height() / 2;
    
    var mx = window_mouse_get_x();
    var my = window_mouse_get_y();
    
    var dx = mx - center_x;
    var dy = my - center_y;
    
    mouse_game_x = clamp(mouse_game_x + dx * 0.5, 0, 639);
    mouse_game_y = clamp(mouse_game_y + dy * 0.5, 0, 479);
    
    window_mouse_set(center_x, center_y);
    
} else {
    var mx = window_mouse_get_x();
    var my = window_mouse_get_y();
    var scale = window_get_width() / 640;
    
    mouse_game_x = mx / scale;
    mouse_game_y = my / scale;
    
    if (mouse_game_x < 0 || mouse_game_x > 639 || mouse_game_y < 0 || mouse_game_y > 479) {
        mouse_game_x = clamp(mouse_game_x, 0, 639);
        mouse_game_y = clamp(mouse_game_y, 0, 479);
        window_mouse_set(mouse_game_x * scale, mouse_game_y * scale);
    }
}

mouse_clamped_x = mouse_game_x;
mouse_clamped_y = mouse_game_y;

// --- Ensure player exists ---
// [rest of your code continues here...]

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
                // Check for intersection
                var intersection = scr_path_has_intersection(brush_points);
                
                if (intersection[0]) {  // Found intersection!
                    // Extract just the loop
                    var loop = scr_extract_loop(brush_points, intersection[1], intersection[2], intersection[3], intersection[4]);
                    
                    brush_circles_completed += 1;
                    
                    if (brush_circles_completed < 3) {
                        // Create slow zone with loop
                        var zone = instance_create_layer(0, 0, "Instances", obj_slow_zone);
                        zone.polygon_points = loop;  // Use the extracted loop
                        zone.is_freeze_zone = false;
                        
                        with (obj_enemy_base) {
                            if (point_in_polygon(x, y, loop)) {
                                slow_stacks += 1;
                            }
                        }
                    } else {
                        // Freeze zone
                        var zone = instance_create_layer(0, 0, "Instances", obj_slow_zone);
                        zone.polygon_points = loop;
                        zone.is_freeze_zone = true;
                    }
                    
                    // Continue drawing from intersection point
                    ds_list_clear(brush_points);
                    ds_list_add(brush_points, intersection[3], intersection[4]);
                    
                    show_debug_message("Loop " + string(brush_circles_completed) + " detected!");
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