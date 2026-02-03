// === LIFETIME ===
// Meteors don't use lifetime countdown
if (!is_meteor && lifetime > 0) {
    lifetime -= 1;
    if (lifetime <= 0) {
        ds_list_destroy(polygon_points);
        instance_destroy();
        exit;
    }
}

// === FREEZE ENEMIES ===
// Only freeze if not a meteor (meteor handles its own enemies)
if (is_freeze_zone && !is_meteor) {
    with (obj_enemy_base) {
        if (point_in_polygon(x, y, other.polygon_points)) {
            speed_mult = 0;
        }
    }
}

// === METEOR SYSTEM ===
if (is_meteor) {
    show_debug_message("is_meteor=true, meteor_moving=" + string(meteor_moving) + ", bounces=" + string(bounces_remaining));
    
    if (meteor_moving) {
        show_debug_message("meteor_x=" + string(meteor_x) + ", meteor_y=" + string(meteor_y) + ", dir=" + string(meteor_direction) + ", speed=" + string(meteor_speed));
        
        // Move meteor center
        meteor_x += lengthdir_x(meteor_speed, meteor_direction);
        meteor_y += lengthdir_y(meteor_speed, meteor_direction);
        
        // Move all polygon points
        var dx = lengthdir_x(meteor_speed, meteor_direction);
        var dy = lengthdir_y(meteor_speed, meteor_direction);
        for (var i = 0; i < ds_list_size(polygon_points); i += 2) {
            polygon_points[| i] += dx;
            polygon_points[| i + 1] += dy;
        }
        
        // Wall bouncing
        if (meteor_x <= 0 || meteor_x >= room_width) {
            meteor_direction = 180 - meteor_direction;
            bounces_remaining -= 1;
        }
        if (meteor_y <= 0 || meteor_y >= room_height) {
            meteor_direction = -meteor_direction;
            bounces_remaining -= 1;
        }
        
        // Kill enemies on contact
        with (obj_enemy_base) {
            if (point_in_polygon(x, y, other.polygon_points)) {
                instance_destroy();
            }
        }
        
        // Destroy when out of bounces
        if (bounces_remaining <= 0) {
            ds_list_destroy(polygon_points);
            instance_destroy();
            exit;
        }
    } else {
        // Waiting for tongue hit
        show_debug_message("Waiting for tongue...");
        if (instance_exists(obj_tongue)) {
            var t = obj_tongue;
            show_debug_message("Tongue: moving=" + string(t.moving) + ", retracting=" + string(t.retracting) + ", inPolygon=" + string(point_in_polygon(t.x, t.y, polygon_points)));
            if (t.moving && !t.retracting) {
                if (point_in_polygon(t.x, t.y, polygon_points)) {
                    meteor_moving = true;
                    meteor_direction = t.move_direction;
                    t.retracting = true;
                    meteor_speed = 8;
                    bounces_remaining = max(meteor_enemy_count, 1);
                    show_debug_message("METEOR LAUNCHED! bounces=" + string(bounces_remaining));
                }
            }
        }
    }
}