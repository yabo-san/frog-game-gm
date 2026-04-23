event_inherited();

// Countdown — disappears when time runs out
lifetime -= speed_mult;
if (lifetime <= 0) {
    instance_destroy();
    exit;
}

// Flee from player — move away erratically
if (instance_exists(obj_player)) {
    var flee_angle = point_direction(obj_player.x, obj_player.y, x, y);
    var diff = angle_difference(flee_angle, move_direction);
    move_direction += clamp(diff, -5, 5);
}

wiggle_offset += 12;
var wobble = sin(degtorad(wiggle_offset)) * 2;
x += lengthdir_x(move_speed * speed_mult, move_direction) + lengthdir_x(wobble, move_direction + 90);
y += lengthdir_y(move_speed * speed_mult, move_direction) + lengthdir_y(wobble, move_direction + 90);

// Bounce off room edges
if (x < 16) { x = 16; move_direction = 180 - move_direction; }
if (x > room_width - 16) { x = room_width - 16; move_direction = 180 - move_direction; }
if (y < 16) { y = 16; move_direction = -move_direction; }
if (y > room_height - 16) { y = room_height - 16; move_direction = -move_direction; }
