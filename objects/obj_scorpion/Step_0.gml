event_inherited();

if (state == "stunned") {
    // Stunned — no movement, waiting to be eaten
    stun_timer -= 1;
    if (stun_timer <= 0) {
        // Recover
        state = "strafe";
        eatable = false;
        lunge_timer = lunge_cooldown;
    }

    // Stinger droops (retract to rest)
    lunge_extend = max(lunge_extend - 0.05, 0);

} else if (state == "strafe") {
    // Circle strafe the player
    if (instance_exists(obj_player)) {
        var px = obj_player.x;
        var py = obj_player.y;

        orbit_angle += orbit_speed * speed_mult;

        var target_x = px + lengthdir_x(orbit_radius, orbit_angle);
        var target_y = py + lengthdir_y(orbit_radius, orbit_angle);

        var dx = target_x - x;
        var dy = target_y - y;
        var dist = point_distance(x, y, target_x, target_y);

        if (dist > 1) {
            var spd = min(move_speed * speed_mult, dist);
            x += (dx / dist) * spd;
            y += (dy / dist) * spd;
        }

        // Face the player
        facing_angle = point_direction(x, y, px, py);
    }

    x = clamp(x, 16, room_width - 16);
    y = clamp(y, 16, room_height - 16);

    // Countdown to lunge
    lunge_timer -= speed_mult;
    if (lunge_timer <= 0 && instance_exists(obj_player)) {
        state = "lunge";
        lunge_charge_timer = lunge_duration;
        lunge_extend = 0;
        lunge_target_x = obj_player.x;
        lunge_target_y = obj_player.y;
    }

} else if (state == "lunge") {
    // Stinger extends toward the locked target
    lunge_extend = min(lunge_extend + lunge_speed, 1);
    lunge_charge_timer -= speed_mult;

    // Scorpion stays put during lunge (body doesn't move)
    // Face the lunge target
    facing_angle = point_direction(x, y, lunge_target_x, lunge_target_y);

    if (lunge_charge_timer <= 0) {
        // Lunge over, retract and resume strafing
        state = "strafe";
        lunge_timer = lunge_cooldown;
        lunge_extend = 0;
    }
}

// Calculate stinger tip position
// Tail arcs up and over the body, tip extends toward facing direction during lunge
var tail_base_angle = facing_angle + 180;  // tail starts behind body
var tip_angle = lerp(tail_base_angle, facing_angle, lunge_extend);
var tip_dist = tail_length * (0.5 + 0.5 * lunge_extend);
stinger_tip_x = x + lengthdir_x(tip_dist, tip_angle);
stinger_tip_y = y + lengthdir_y(tip_dist, tip_angle);
