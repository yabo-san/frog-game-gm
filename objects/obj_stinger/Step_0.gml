// --- Homing / movement code ---
if (homing && !parried && instance_exists(obj_player)) {
    target_x = obj_player.x;
    target_y = obj_player.y;
    var desired_dir = point_direction(x, y, target_x, target_y);
    var turn_speed = 10;
    var delta = angle_difference(direction, desired_dir);
    if (abs(delta) < turn_speed) direction = desired_dir;
    else direction += turn_speed * sign(delta);
}
x += lengthdir_x(speed, direction);
y += lengthdir_y(speed, direction);

// --- Collision with tongue (parry) ---
var t = instance_place(x, y, obj_tongue);
if (t != noone && !parried && t.moving) {
    scr_parry(id);
    t.moving = false;
}

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