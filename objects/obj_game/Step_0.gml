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
    // Only add point if mouse moved enough (avoid duplicates)
    var last_x = brush_points[| ds_list_size(brush_points) - 2];
    var last_y = brush_points[| ds_list_size(brush_points) - 1];
    var dist = point_distance(last_x, last_y, mouse_clamped_x, mouse_clamped_y);
    
    if (dist > 5) {  // Only add if moved at least 5 pixels
        ds_list_add(brush_points, mouse_clamped_x, mouse_clamped_y);
    }
}

// Finish drawing on release
if (brush_drawing && mouse_check_button_released(mb_right)) {
    // Check if shape is closed (start and end points close together)
    if (ds_list_size(brush_points) >= 4) {
        var start_x = brush_points[| 0];
        var start_y = brush_points[| 1];
        var end_x = brush_points[| ds_list_size(brush_points) - 2];
        var end_y = brush_points[| ds_list_size(brush_points) - 1];
        var close_dist = point_distance(start_x, start_y, end_x, end_y);
        
        if (close_dist < 30) {  // Grace distance for closing the loop
            // Shape is closed! TODO: Create slow zone
            show_debug_message("Closed shape created!");
        }
    }
    
    brush_drawing = false;
    ds_list_clear(brush_points);  // Clear after finishing
}