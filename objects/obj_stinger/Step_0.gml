// Only stop if inside a meteor zone (not regular freeze zones)
with (obj_slow_zone) {
    if (is_meteor && point_in_polygon(other.x, other.y, polygon_points)) {
        instance_destroy(other.id);  // Just destroy stingers that touch
        exit;
    }
}

var t = instance_place(x, y, obj_tongue);
if (t != noone && !parried && t.moving && !t.retracting) {
    // Capture tongue's direction BEFORE retracting
    var tongue_dir = t.move_direction;
    
    // Parry the stinger with captured direction
    scr_parry(id, tongue_dir);
    
    // Make tongue retract
    t.retracting = true;
}

// --- Movement code - HAPPENS AFTER PARRY ---
x += lengthdir_x(speed, direction);
y += lengthdir_y(speed, direction);
image_angle = direction;


// --- Collision with enemies when parried ---
if (parried) {
    with (all) {
        if (variable_instance_exists(id, "is_enemy") && is_enemy) {
            if (place_meeting(other.x, other.y, id) && id != other.owner) { 
                switch(reaction_parried) {
                    case "eatable":
                        eatable = true;
                        scr_update_eatable(id);
                        break;
                    case "damage":
                        scr_damage_enemy(id, 1);
                        break;
                    case "immune":
                        // do nothing
                        break;
                }
            }
        }
    }
}

// --- Collision with player ---
if (!parried && place_meeting(x, y, obj_player)) {
    scr_damage_player(1, id);
    instance_destroy();
}

// --- Lifetime / offscreen ---
lifetime -= 1;
if (lifetime <= 0) instance_destroy();
if (x < -32 || x > room_width + 32 || y < -32 || y > room_height + 32) {
    instance_destroy();
}