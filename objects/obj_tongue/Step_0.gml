/// --- Move tongue toward target or retract ---
if (moving) {
    // Determine destination (target if extending, frog if retracting)
    var dest_x = retracting ? frog.x : target_x;
    var dest_y = retracting ? frog.y : target_y;
    
    var dx = dest_x - x;
    var dy = dest_y - y;
    var dist = point_distance(x, y, dest_x, dest_y);

    if (dist > tongue_speed) {
		
		move_direction = point_direction(x, y, dest_x, dest_y);

        x += dx / dist * tongue_speed;
        y += dy / dist * tongue_speed;
    } else {
        // Reached destination
        x = dest_x;
        y = dest_y;
        
        if (retracting) {
            // Finished retracting - destroy tongue
            instance_destroy();
            exit;
        } else {
            // Reached target normally - stop moving
            moving = false;
        }
    }

    /// --- Collision with enemies (only while extending, not retracting) ---
    if (!retracting) {
        var enemy = instance_place(x, y, obj_enemy_base);
        if (enemy != noone) {
            if (enemy.eatable) {
                // Pass through eatable enemies
            } else if (enemy.object_index == obj_snail) {
                // Snail handles its own tongue collision (knockback)
                retracting = true;
            } else {
                // Hit non-eatable enemy — deal damage, then retract
                scr_damage_enemy(enemy, 1);
                retracting = true;
            }
        }
    }
}

/// --- Update drawing variables ---
if (instance_exists(frog)) {
    tongue_dx = x - frog.x;
    tongue_dy = y - frog.y;
    tongue_length = point_distance(frog.x, frog.y, x, y);
    tongue_angle = point_direction(frog.x, frog.y, x, y);
}