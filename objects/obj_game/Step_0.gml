if (keyboard_check_pressed(ord("R"))) {
    game_restart();
}

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

// Scale mouse movement by inverse of game speed to keep it feeling normal
var speed_compensation = 1.0 / cfg("debug.game_speed_multiplier");
if (speed_compensation != 1.0) {
    // Store previous mouse position
    if (!variable_instance_exists(id, "prev_mouse_x")) {
        prev_mouse_x = mouse_clamped_x;
        prev_mouse_y = mouse_clamped_y;
    }
    
    // Calculate mouse delta and scale it
    var dx = (mouse_clamped_x - prev_mouse_x) * (speed_compensation - 1.0);
    var dy = (mouse_clamped_y - prev_mouse_y) * (speed_compensation - 1.0);
    
    mouse_clamped_x = clamp(mouse_clamped_x + dx, 0, 639);
    mouse_clamped_y = clamp(mouse_clamped_y + dy, 0, 479);
    
    prev_mouse_x = mouse_clamped_x;
    prev_mouse_y = mouse_clamped_y;
}

// --- Ensure player exists ---
if (!instance_exists(player)) {
    player = instance_create_layer(room_width/2, room_height/2, "Instances", obj_player);
}

// --- Ensure brush exists and has player reference ---
if (!instance_exists(brush)) {
    brush = instance_create_layer(0, 0, "Instances", obj_brush);
}
brush.player = player;

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

    var enemy_type = choose(obj_bee, obj_fly, obj_snail);
    var e = instance_create_layer(spawn_x, spawn_y, "Instances", enemy_type);

    if (instance_exists(player)) {
        e.target_x = player.x;
        e.target_y = player.y;
    } else {
        e.target_x = room_width/2;
        e.target_y = room_height/2;
    }
}