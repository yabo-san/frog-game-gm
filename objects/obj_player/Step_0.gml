// --- Invulnerability countdown ---
if (invuln_timer > 0) invuln_timer -= 1;

// --- Spawn tongue when clicking (only if no tongue exists) ---
if (mouse_check_button_pressed(mb_left) && !instance_exists(tongue)) {
    tongue = instance_create_layer(x, y, "Instances", obj_tongue);
    global.current_chain = 0
    tongue.frog = id;
    tongue.target_x = obj_game.mouse_game_x;
    tongue.target_y = obj_game.mouse_game_y;
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
    var is_worm = (eat_enemy.object_index == obj_earthworm);
    instance_destroy(eat_enemy);
    scr_update_score(pts);
    global.current_chain += 1;

    // Earthworm tops off ink
    if (is_worm && instance_exists(obj_brush)) {
        obj_brush.ink_current = obj_brush.ink_max;
    }
}

// --- Check collision with non-eatable enemies (DAMAGE PLAYER) ---
// Snail handles its own collision (game over + not destroyed by generic check)
var enemy = instance_place(x, y, obj_enemy_base);
if (enemy != noone && !enemy.eatable && enemy.object_index != obj_snail) {
    scr_damage_player(enemy.contact_damage, enemy);
    instance_destroy(enemy);
}

// Depth sorting for fake 3D (fixed camera = Y-sort works)
if (global.view_mode != "2d") {
    depth = -y;
} else {
    depth = 0;
}