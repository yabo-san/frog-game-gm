/// Begin Step — handle tongue and player collision per segment

// Segment positions: head = current pos, others trail from history
var seg_positions = array_create(num_segments);
seg_positions[0] = { hx: x, hy: y };
for (var i = 1; i < num_segments; i++) {
    var hist_idx = (history_index - i * seg_spacing + history_len * 10) mod history_len;
    seg_positions[i] = pos_history[hist_idx];
}

// Map segments to zones (distribute segments across 3 zones)
// e.g. 9 segments: zone 0 = seg 0-2, zone 1 = seg 3-5, zone 2 = seg 6-8
var segs_per_zone = num_segments div 3;

// --- Tongue collision ---
if (instance_exists(obj_tongue)) {
    var t = obj_tongue;
    if (t.moving && !t.retracting) {
        for (var i = 0; i < num_segments; i++) {
            var sx = seg_positions[i].hx;
            var sy = seg_positions[i].hy;
            if (point_distance(t.x, t.y, sx, sy) < seg_radius) {
                var zone = clamp(i div segs_per_zone, 0, 2);
                if (!zone_painted[zone]) {
                    // Paint this zone
                    zone_painted[zone] = true;
                    zones_remaining -= 1;
                    if (zones_remaining <= 0) {
                        eatable = true;
                    }
                }
                // Tongue always retracts on caterpillar hit (even when painting)
                if (!eatable) {
                    t.retracting = true;
                }
                break;
            }
        }
    }
}

// --- Parried stinger collision (passes through, paints each zone it touches) ---
with (obj_stinger) {
    if (parried) {
        for (var i = 0; i < other.num_segments; i++) {
            var sx = seg_positions[i].hx;
            var sy = seg_positions[i].hy;
            if (point_distance(x, y, sx, sy) < other.seg_radius) {
                var zone = clamp(i div segs_per_zone, 0, 2);
                if (!other.zone_painted[zone]) {
                    other.zone_painted[zone] = true;
                    other.zones_remaining -= 1;
                    if (other.zones_remaining <= 0) {
                        other.eatable = true;
                    }
                }
                // Stinger does NOT stop — passes through to hit more zones
                break;  // only one segment per zone per frame, stinger keeps moving
            }
        }
    }
}

// --- Player collision ---
if (instance_exists(obj_player)) {
    var p = obj_player;
    for (var i = 0; i < num_segments; i++) {
        var sx = seg_positions[i].hx;
        var sy = seg_positions[i].hy;
        if (point_distance(p.x, p.y, sx, sy) < seg_radius + 6) {
            if (eatable) {
                // Eat the caterpillar
                scr_update_score(points);
                global.current_chain += 1;
                instance_destroy();
                exit;
            } else {
                // Kill the player
                scr_damage_player(1, id);
            }
            break;
        }
    }
}
