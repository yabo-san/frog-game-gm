event_inherited();

// --- Fire timer ---
if (!can_fire) {
    fire_timer -= 1;
    if (fire_timer <= 0) can_fire = true;
}

// --- Fire logic — scattered burst toward player ---
if (can_fire && instance_exists(obj_player)
    && x > 0 && x < room_width && y > 0 && y < room_height) {
    var bee_id = id;
    var base_dir = point_direction(x, y, obj_player.x, obj_player.y);
    var burst = enemy_cfg("heavy_bee", "burst_count");
    var spread = enemy_cfg("heavy_bee", "burst_spread");
    var spd = enemy_cfg("heavy_bee", "stinger_speed");

    for (var i = 0; i < burst; i++) {
        var s = instance_create_layer(x, y, "Instances", obj_stinger);
        s.direction = base_dir + random_range(-spread, spread);
        s.image_angle = s.direction;
        s.owner = bee_id;
        s.speed = spd + random_range(-0.5, 0.5);
        s.heavy = true;
    }

    can_fire = false;
    fire_timer = fire_cooldown;
}

// --- Move straight toward player ---
if (instance_exists(obj_player)) {
    var dir_to_player = point_direction(x, y, obj_player.x, obj_player.y);
    x += lengthdir_x(move_speed * speed_mult, dir_to_player);
    y += lengthdir_y(move_speed * speed_mult, dir_to_player);
}

x = clamp(x, 8, room_width - 8);
y = clamp(y, 8, room_height - 8);
