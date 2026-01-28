function scr_parry(stinger) {
    stinger.parried = true;
    stinger.homing = false;

    // Calculate original trajectory relative to tongue
    var dx = stinger.x - obj_tongue.x;
    var dy = stinger.y - obj_tongue.y;
    var angle = point_direction(0, 0, dx, dy);

    motion_set(angle, stinger.speed); // apply new trajectory
}
