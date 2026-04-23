event_inherited();

// Move straight toward the player
if (instance_exists(obj_player)) {
    var dir_to_player = point_direction(x, y, obj_player.x, obj_player.y);
    x += lengthdir_x(move_speed * speed_mult, dir_to_player);
    y += lengthdir_y(move_speed * speed_mult, dir_to_player);
}

x = clamp(x, 0, room_width);
y = clamp(y, 0, room_height);
