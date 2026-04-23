event_inherited();

// Seesaw: oscillate along shared axis, phase determines direction
osc_timer += osc_speed * speed_mult;

// Drift anchor toward player
if (instance_exists(obj_player)) {
    var dir_to_player = point_direction(base_x, base_y, obj_player.x, obj_player.y);
    base_x += lengthdir_x(drift_speed * speed_mult, dir_to_player);
    base_y += lengthdir_y(drift_speed * speed_mult, dir_to_player);
}

// Keep anchor in bounds
var margin = 40;
base_x = clamp(base_x, margin, room_width - margin);
base_y = clamp(base_y, margin, room_height - margin);

// Oscillate — phase offset creates the seesaw (one goes left while other goes right)
var offset = sin(degtorad(osc_timer + osc_phase)) * osc_amplitude;
x = base_x + lengthdir_x(offset, osc_axis);
y = base_y + lengthdir_y(offset, osc_axis);

x = clamp(x, 8, room_width - 8);
y = clamp(y, 8, room_height - 8);
