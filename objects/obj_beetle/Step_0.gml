event_inherited();

if (state == "aim") {
    // Stationary — slowly rotate toward player
    if (instance_exists(obj_player)) {
        var target_angle = point_direction(x, y, obj_player.x, obj_player.y);
        var diff = angle_difference(target_angle, facing_angle);
        facing_angle += clamp(diff, -turn_speed, turn_speed) * speed_mult;
    }

    aim_timer -= speed_mult;
    if (aim_timer <= 0) {
        state = "charge";
        charge_timer = charge_duration;
    }

} else if (state == "charge") {
    // Rush forward in facing direction
    x += lengthdir_x(charge_speed * speed_mult, facing_angle);
    y += lengthdir_y(charge_speed * speed_mult, facing_angle);

    charge_timer -= speed_mult;

    // Stop charging if timer runs out or we leave the room
    if (charge_timer <= 0 || x < -64 || x > room_width + 64 || y < -64 || y > room_height + 64) {
        state = "aim";
        aim_timer = cfg("enemies.beetle.aim_time");

        // Clamp back into room if we overshot
        x = clamp(x, 0, room_width);
        y = clamp(y, 0, room_height);
    }
}
