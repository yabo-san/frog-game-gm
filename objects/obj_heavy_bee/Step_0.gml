event_inherited();

// --- Count active stingers ---
var bee_id = id;
var active_stingers = 0;
with (obj_stinger) {
    if (owner == bee_id) active_stingers += 1;
}

// --- Fire timer ---
if (!can_fire) {
    fire_timer -= 1;
    if (fire_timer <= 0) can_fire = true;
}

// --- Fire logic — shoots larger stingers ---
if (can_fire && instance_exists(obj_player) && active_stingers < max_active_stingers
    && x > 0 && x < room_width && y > 0 && y < room_height) {
    var s = instance_create_layer(x, y, "Instances", obj_stinger);
    s.direction = point_direction(x, y, obj_player.x, obj_player.y);
    s.image_angle = s.direction;
    s.owner = bee_id;
    s.speed = cfg("enemies.heavy_bee.stinger_speed");
    // Mark as heavy stinger for larger drawing
    s.heavy = true;
    can_fire = false;
    fire_timer = fire_cooldown;
}

// --- Random walk movement ---
if (move_timer > 0) {
    x += lengthdir_x(move_speed * speed_mult, move_direction);
    y += lengthdir_y(move_speed * speed_mult, move_direction);
    move_timer -= 1;
    x = clamp(x, 0, room_width);
    y = clamp(y, 0, room_height);
    if (move_timer <= 0) stop_timer = irandom_range(30, 90);
} else if (stop_timer > 0) {
    stop_timer -= 1;
    if (stop_timer <= 0) {
        move_direction = irandom(359);
        move_timer = irandom_range(60, 120);
    }
}
