event_inherited();
// March toward player
if (instance_exists(obj_player)) {
    var dx = obj_player.x - x;
    var dy = obj_player.y - y;
    var dist = point_distance(x, y, obj_player.x, obj_player.y);
    if (dist > 0) {
        x += (dx / dist) * move_speed * speed_mult;
        y += (dy / dist) * move_speed * speed_mult;
    }
}

// Collision with parried stinger
var s = instance_place(x, y, obj_stinger);
if (s != noone && s.parried) {
    eatable = true;
}
