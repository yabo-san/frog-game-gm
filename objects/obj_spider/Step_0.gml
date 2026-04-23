event_inherited();

// Random walk — like fly but constrained to one axis to stay useful
if (move_timer > 0) {
    x += lengthdir_x(move_speed * speed_mult, move_direction);
    y += lengthdir_y(move_speed * speed_mult, move_direction);
    x = clamp(x, 16, room_width - 16);
    y = clamp(y, 16, room_height - 16);
    move_timer -= 1;
} else if (stop_timer > 0) {
    stop_timer -= 1;
} else {
    move_direction = irandom(359);
    move_timer = irandom_range(60, 120);
    stop_timer = irandom_range(30, 90);
}

// Keep web following
if (instance_exists(web)) {
    web.x = x;
    web.y = y;
}
