/// Begin Step — handle all collisions ourselves (no sprite = no instance_place detection)
var r = beetle_radius;

// If armor is already broken (hit by parried stinger), stay eatable from all sides
if (hp <= 0) {
    eatable = true;
} else {
    eatable = false;
}

// --- Tongue collision ---
var _tongue = instance_nearest(x, y, obj_tongue);
if (instance_exists(_tongue) && _tongue.moving && point_distance(x, y, _tongue.x, _tongue.y) < r) {
    if (eatable) {
        // Armor broken — tongue passes through
    } else {
        var angle_to = point_direction(x, y, _tongue.x, _tongue.y);
        var diff = angle_difference(angle_to, facing_angle);

        if (abs(diff) <= 90) {
            // Front hit — deflect tongue
            if (!_tongue.retracting) {
                _tongue.retracting = true;
            }
        } else {
            // Back hit — tongue passes through, mark eatable for player eat
            eatable = true;
        }
    }
}

// --- Player collision ---
if (instance_exists(obj_player)) {
    var _p = obj_player;
    if (point_distance(x, y, _p.x, _p.y) < r + 8) {
        if (eatable) {
            // Armor broken or back contact — player eats beetle
            var pts = points;
            scr_update_score(pts);
            global.current_chain += 1;
            instance_destroy();
            exit;
        }

        var angle_to = point_direction(x, y, _p.x, _p.y);
        var diff = angle_difference(angle_to, facing_angle);

        if (abs(diff) > 90) {
            // Back hit — player eats beetle
            var pts = points;
            scr_update_score(pts);
            global.current_chain += 1;
            instance_destroy();
            exit;
        } else {
            // Front hit — damage player, beetle destroyed
            scr_damage_player(contact_damage, id);
            instance_destroy();
            exit;
        }
    }
}

// --- Parried stinger collision ---
with (obj_stinger) {
    if (parried && point_distance(x, y, other.x, other.y) < other.beetle_radius) {
        scr_damage_enemy(other.id, 1);
    }
}
