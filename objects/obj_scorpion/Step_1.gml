/// Begin Step — handle tongue/player collision

// --- Tongue vs stinger tip (only during lunge) ---
if (state == "lunge" && instance_exists(obj_tongue)) {
    var t = obj_tongue;
    if (t.moving && !t.retracting) {
        if (point_distance(t.x, t.y, stinger_tip_x, stinger_tip_y) < 10) {
            // Tongue hit the stinger — stun the scorpion
            state = "stunned";
            stun_timer = stun_duration;
            eatable = true;
            t.retracting = true;
        }
    }
}

// --- Tongue vs body (deflects unless stunned) ---
if (!eatable && instance_exists(obj_tongue)) {
    var t = obj_tongue;
    if (t.moving && !t.retracting) {
        if (point_distance(t.x, t.y, x, y) < body_radius) {
            t.retracting = true;
        }
    }
}

// --- Player collision ---
if (instance_exists(obj_player)) {
    var p = obj_player;

    // Body contact
    if (point_distance(p.x, p.y, x, y) < body_radius + 6) {
        if (eatable) {
            scr_update_score(points);
            global.current_chain += 1;
            instance_destroy();
            exit;
        } else {
            scr_damage_player(1, id);
        }
    }

    // Stinger tip contact (lethal during lunge, not during stun)
    if (state == "lunge" && point_distance(p.x, p.y, stinger_tip_x, stinger_tip_y) < 8) {
        scr_damage_player(1, id);
    }
}
