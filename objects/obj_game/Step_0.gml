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





// --- Brush Start ---
//if (mouse_check_button_pressed(mb_right)) {
//    if (!ds_exists(brush_points, ds_type_list)) brush_points = ds_list_create();
//    ds_list_clear(brush_points);
//    brush_drawing = true;

//    var mx = clamp(mouse_clamped_x, 0, view_wview[0]);
//    var my = clamp(mouse_clamped_y, 0, view_hview[0]);
//    ds_list_add(brush_points, mx);
//    ds_list_add(brush_points, my);
//}

//// --- Brush Continue ---
//if (brush_drawing && mouse_check_button(mb_right)) {
//    var mx = clamp(mouse_clamped_x, 0, view_wview[0]);
//    var my = clamp(mouse_clamped_y, 0, view_hview[0]);
//    ds_list_add(brush_points, mx);
//    ds_list_add(brush_points, my);
//}

//// --- Brush Finish ---
//if (brush_drawing && mouse_check_button_released(mb_right)) {
//    brush_drawing = false;

//    if (ds_exists(brush_points, ds_type_list) && ds_list_size(brush_points) >= 6) {
//        with (obj_enemy_base) {
//            show_debug_message("here")
//            if (point_in_polygon(x, y, brush_points)) {
//                effect = "slow";
//                effect_timer = 180; // 3 seconds
//            }
//        }
//    }

//    ds_list_clear(brush_points);
//}
