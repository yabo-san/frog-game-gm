event_inherited();

// Erratic flutter — like fly but faster direction changes and sine wobble
if (move_timer > 0) {
    flutter_offset += 8;
    var wobble = sin(degtorad(flutter_offset)) * 1.5;
    var dx = lengthdir_x(move_speed * speed_mult, move_direction) + lengthdir_x(wobble, move_direction + 90);
    var dy = lengthdir_y(move_speed * speed_mult, move_direction) + lengthdir_y(wobble, move_direction + 90);
    x += dx;
    y += dy;

    x = clamp(x, 0, room_width);
    y = clamp(y, 0, room_height);

    move_timer -= 1;
} else if (stop_timer > 0) {
    stop_timer -= 1;
} else {
    // Pick new direction — shorter cycles than fly for erratic feel
    move_direction = irandom(359);
    move_timer = irandom_range(30, 60);
    stop_timer = irandom_range(10, 30);
}
