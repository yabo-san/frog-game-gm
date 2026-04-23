event_inherited();

// --- Shell state: knocked back, invulnerable, stopped ---
if (in_shell) {
    // Apply knockback
    x += knockback_dx;
    y += knockback_dy;
    knockback_dx *= 0.9;
    knockback_dy *= 0.9;

    x = clamp(x, 8, room_width - 8);
    y = clamp(y, 8, room_height - 8);

    shell_timer -= speed_mult;
    if (shell_timer <= 0) {
        in_shell = false;
    }
    exit;
}

// --- Tongue hit: knockback + shell ---
if (instance_exists(obj_tongue)) {
    var t = obj_tongue;
    if (t.moving && !t.retracting && place_meeting(x, y, t)) {
        in_shell = true;
        shell_timer = shell_duration;
        var knock_dir = point_direction(t.x, t.y, x, y);
        knockback_dx = lengthdir_x(knockback_force, knock_dir);
        knockback_dy = lengthdir_y(knockback_force, knock_dir);
        t.retracting = true;
        exit;
    }
}

// --- Stinger collision: any stinger kills the snail ---
var s = instance_place(x, y, obj_stinger);
if (s != noone) {
    scr_update_score(points);
    instance_destroy(s);
    instance_destroy();
    exit;
}

// --- Player contact: game over ---
if (instance_exists(obj_player) && place_meeting(x, y, obj_player)) {
    scr_damage_player(contact_damage, id);
}

// --- March toward player ---
if (instance_exists(obj_player)) {
    var dx = obj_player.x - x;
    var dy = obj_player.y - y;
    var dist = point_distance(x, y, obj_player.x, obj_player.y);
    if (dist > 0) {
        x += (dx / dist) * move_speed * speed_mult;
        y += (dy / dist) * move_speed * speed_mult;
    }
}
