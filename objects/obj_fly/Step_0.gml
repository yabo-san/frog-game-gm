event_inherited();
// Countdown timers
if (move_timer > 0) {
    // Move in current random direction
    x += lengthdir_x(move_speed * speed_mult, move_direction);
    y += lengthdir_y(move_speed * speed_mult, move_direction);

    move_timer -= 1;

    // Optional: stop if hitting room edges
    if (x < 0) x = 0;
    if (x > room_width) x = room_width;
    if (y < 0) y = 0;
    if (y > room_height) y = room_height;

    // When timer ends, start stop phase
    if (move_timer <= 0) {
        stop_timer = irandom_range(30, 90);   // frames to pause
    }

} else if (stop_timer > 0) {
    stop_timer -= 1;

    // When stop timer ends, pick new random direction and move
    if (stop_timer <= 0) {
        move_direction = irandom(359);          // new random heading
        move_timer = irandom_range(60, 120);    // frames to move
    }
}


