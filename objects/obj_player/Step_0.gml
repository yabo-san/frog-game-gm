// --- Spawn tongue when clicking (only if no tongue exists) ---
if (mouse_check_button_pressed(mb_left) && !instance_exists(tongue)) {
    tongue = instance_create_layer(x, y, "Instances", obj_tongue);
    global.current_chain = 0
    tongue.frog = id;
    tongue.target_x = mouse_x;
    tongue.target_y = mouse_y;
    tongue.moving = true;
    tongue.retracting = false;
}

// --- Follow tongue only if it exists, has STOPPED moving, and is NOT retracting ---
if (instance_exists(tongue) && !tongue.moving && !tongue.retracting) {
    var dx = tongue.x - x;
    var dy = tongue.y - y;
    var dist = point_distance(x, y, tongue.x, tongue.y);

    if (dist > follow_speed) {
        x += dx / dist * follow_speed;
        y += dy / dist * follow_speed;
    } else {
        // Frog reached tongue - destroy it
        x = tongue.x;
        y = tongue.y;
        instance_destroy(tongue);
        tongue = noone;
    }
}

// --- Frog eats enemies along its path ---
var eat_enemy = instance_place(x, y, obj_enemy_base);
if (eat_enemy != noone && eat_enemy.eatable) {
    var pts = eat_enemy.points;
    instance_destroy(eat_enemy);
    scr_update_score(pts);
    global.current_chain += 1;
}

// --- Check collision with non-eatable enemies (DAMAGE PLAYER) ---
var enemy = instance_place(x, y, obj_enemy_base);
if (enemy != noone && !enemy.eatable) {
    scr_damage_player(1, enemy);
    // Optional: destroy the enemy on contact
    // instance_destroy(enemy);
}
// show_debug_message(hp)