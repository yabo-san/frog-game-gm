if (keyboard_check_pressed(ord("R"))) {
    game_restart();
}

// --- View mode toggle (V key) ---
if (keyboard_check_pressed(ord("V"))) {
    if (global.view_mode == "2d") {
        global.view_mode = "3d";
        layer_force_draw_depth(true, layer_get_id("Instances"));
    } else {
        global.view_mode = "2d";
        layer_force_draw_depth(false, layer_get_id("Instances"));
    }
}

/*  --- First person (commented out, press V for 3/4 view instead) ---
if (global.view_mode == "fp" && instance_exists(player)) {
    var _c = global.cam;
    _c.cam_x = player.x - _c.cam_width / 2;
    _c.cam_y = player.y - _c.cam_height / 2;
    _c.cam_z = 12;
    var scr_cx = window_get_width() / 2;
    var scr_cy = window_get_height() / 2;
    var mdx = window_mouse_get_x() - scr_cx;
    var mdy = window_mouse_get_y() - scr_cy;
    _c.cam_rotation += mdx * 0.3;
    _c.cam_pitch = clamp(_c.cam_pitch - mdy * 0.2, -60, 30);
    window_mouse_set(scr_cx, scr_cy);
    var look_world_dir = -_c.cam_rotation + 90;
    var look_dist = 200;
    mouse_game_x = player.x + lengthdir_x(look_dist, look_world_dir);
    mouse_game_y = player.y + lengthdir_y(look_dist, look_world_dir);
    mouse_clamped_x = mouse_game_x;
    mouse_clamped_y = mouse_game_y;
    _c.m00 = lengthdir_x(1, _c.cam_rotation);
    _c.m10 = lengthdir_y(-1, _c.cam_rotation);
    _c.m01 = lengthdir_y(1, _c.cam_rotation);
    _c.m11 = lengthdir_x(1, _c.cam_rotation);
    _c.cam_yscale = lengthdir_y(1, _c.cam_pitch);
    _c.cam_zscale = lengthdir_x(1, _c.cam_pitch);
}
*/

// --- Recalculate play area layout ---
var dw = window_get_width();
var dh = window_get_height();
play_area_scale = dh / 480;
play_area_w = floor(640 * play_area_scale);
play_area_h = dh;
play_area_x = floor((dw - play_area_w) / 2);
play_area_y = 0;
panel_width = play_area_x;

// Set GUI to match window so Draw_64 coordinates = window pixel coordinates
display_set_gui_size(dw, dh);

// --- Fullscreen toggle ---
if (keyboard_check_pressed(ord("F")) && !is_fullscreen) {
    window_set_fullscreen(true);
    is_fullscreen = true;
}
if (keyboard_check_pressed(ord("W")) && is_fullscreen) {
    window_set_fullscreen(false);
    is_fullscreen = false;
    window_set_size(640 * 2, 480 * 2);
}

// --- Mouse handling: absolute mapping to centered play area ---
var mx = window_mouse_get_x();
var my = window_mouse_get_y();

// Map screen position to game surface coords (640x480)
mouse_screen_x = clamp((mx - play_area_x) / play_area_scale, 0, 639);
mouse_screen_y = clamp((my - play_area_y) / play_area_scale, 0, 479);

// Lock OS cursor within the play area bounds on screen
var lock_x = clamp(mx, play_area_x, play_area_x + play_area_w - 1);
var lock_y = clamp(my, play_area_y, play_area_y + play_area_h - 1);
if (mx != lock_x || my != lock_y) {
    window_mouse_set(lock_x, lock_y);
}

// In 2D, game coords = screen coords
mouse_game_x = mouse_screen_x;
mouse_game_y = mouse_screen_y;

// In 3D mode, convert screen mouse to world coords
if (global.view_mode != "2d") {
    sp_to_wp(mouse_screen_x, mouse_screen_y);
    mouse_game_x = clamp(res_world_x, 0, 639);
    mouse_game_y = clamp(res_world_y, 0, 479);
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

    // Rare earthworm chance — 5% per spawn, max 1 at a time
    if (irandom(19) == 0 && !instance_exists(obj_earthworm)) {
        var wx = irandom_range(64, room_width - 64);
        var wy = irandom_range(64, room_height - 64);
        instance_create_layer(wx, wy, "Instances", obj_earthworm);
    }

    var enemy_type = choose(obj_bee, obj_fly, obj_snail, obj_beetle, obj_butterfly, obj_spider, obj_caterpillar, obj_scorpion, obj_heavy_bee);

    // Snail: cap based on rank (max_per_rank array, capped at 4)
    if (enemy_type == obj_snail) {
        var _rank_table = enemy_cfg("snail", "max_per_rank");
        var _rank_idx = clamp(global.rank - 1, 0, array_length(_rank_table) - 1);
        var _max_snails = _rank_table[_rank_idx];
        if (instance_number(obj_snail) >= _max_snails) {
            enemy_type = choose(obj_bee, obj_fly, obj_beetle, obj_butterfly);
        }
    }

    // Spider: max 2, alternating axis, spawn inside room (not off-edge)
    if (enemy_type == obj_spider) {
        if (instance_number(obj_spider) >= 2) {
            enemy_type = choose(obj_bee, obj_fly, obj_snail, obj_beetle, obj_butterfly);
        } else {
            // Alternate axis
            var new_axis = (last_spider_axis == "vertical") ? "horizontal" : "vertical";
            last_spider_axis = new_axis;

            // Spawn at edge — use the already-picked edge spawn position
            // but place along the axis the web runs on
            if (new_axis == "vertical") {
                // Web is vertical, spider spawns at left or right edge
                spawn_x = choose(-32, room_width + 32);
                spawn_y = irandom_range(64, room_height - 64);
            } else {
                // Web is horizontal, spider spawns at top or bottom edge
                spawn_x = irandom_range(64, room_width - 64);
                spawn_y = choose(-32, room_height + 32);
            }

            var e = instance_create_layer(spawn_x, spawn_y, "Instances", obj_spider);
            e.web_axis = new_axis;
            if (instance_exists(e.web)) e.web.axis = new_axis;

            if (instance_exists(player)) {
                e.target_x = player.x;
                e.target_y = player.y;
            } else {
                e.target_x = room_width/2;
                e.target_y = room_height/2;
            }
            exit;
        }
    }

    // Flies spawn in seesaw pairs
    if (enemy_type == obj_fly) {
        var shared_axis = irandom(359);
        for (var fi = 0; fi < 2; fi++) {
            var f = instance_create_layer(spawn_x, spawn_y, "Instances", obj_fly);
            f.osc_axis = shared_axis;
            f.osc_phase = fi * 180;  // opposite phase = seesaw
            f.base_x = spawn_x;
            f.base_y = spawn_y;
            if (instance_exists(player)) {
                f.target_x = player.x;
                f.target_y = player.y;
            }
        }
    } else {
        var e = instance_create_layer(spawn_x, spawn_y, "Instances", enemy_type);
        if (instance_exists(player)) {
            e.target_x = player.x;
            e.target_y = player.y;
        } else {
            e.target_x = room_width/2;
            e.target_y = room_height/2;
        }
    }
}