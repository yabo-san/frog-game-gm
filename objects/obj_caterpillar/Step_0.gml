event_inherited();

// Stunned once fully painted — no movement
if (eatable) {
    // Still record history so segments stay put
    pos_history[history_index] = { hx: x, hy: y };
    history_index = (history_index + 1) mod history_len;
    exit;
}

// Envelope movement — orbit around the player, slowly tightening
if (instance_exists(obj_player)) {
    var px = obj_player.x;
    var py = obj_player.y;

    // Rotate orbit angle
    orbit_angle += orbit_speed * speed_mult;

    // Target point on orbit circle around player
    var target_x = px + lengthdir_x(orbit_radius, orbit_angle);
    var target_y = py + lengthdir_y(orbit_radius, orbit_angle);

    // Move head toward orbit target
    var dx = target_x - x;
    var dy = target_y - y;
    var dist = point_distance(x, y, target_x, target_y);

    if (dist > 1) {
        var spd = min(move_speed * speed_mult, dist);
        x += (dx / dist) * spd;
        y += (dy / dist) * spd;
    }

    // Slowly tighten the orbit to envelope the frog
    if (!eatable) {
        orbit_radius = max(orbit_radius - approach_speed * speed_mult, 30);
    }
}

x = clamp(x, 0, room_width);
y = clamp(y, 0, room_height);

// Record position history
pos_history[history_index] = { hx: x, hy: y };
history_index = (history_index + 1) mod history_len;
