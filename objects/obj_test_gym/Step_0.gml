/// Test Gym — step logic

// --- G: toggle between gauntlet and grid mode ---
if (keyboard_check_pressed(ord("G"))) {
    with (obj_enemy_base) { instance_destroy(); }
    with (obj_web) { instance_destroy(); }

    if (mode == "gauntlet") {
        mode = "grid";
        grid_spawned = false;
    } else {
        mode = "gauntlet";
        gauntlet_index = 0;
        gauntlet_spawned = false;
        gauntlet_active = [];
    }
}

// --- M: toggle movement freeze ---
if (keyboard_check_pressed(ord("M"))) {
    enemies_frozen = !enemies_frozen;
}

// --- Apply freeze ---
with (obj_enemy_base) {
    speed_mult = other.enemies_frozen ? 0 : 1;
}

// --- Invincibility in gauntlet ---
if (mode == "gauntlet" && instance_exists(obj_game.player)) {
    obj_game.player.invuln_timer = 2;
}

// --- T: teleport frog to mouse ---
if (keyboard_check_pressed(ord("T")) && instance_exists(obj_game.player)) {
    obj_game.player.x = obj_game.mouse_game_x;
    obj_game.player.y = obj_game.mouse_game_y;
    if (instance_exists(obj_game.player.tongue)) {
        instance_destroy(obj_game.player.tongue);
        obj_game.player.tongue = noone;
    }
}

// --- Disable normal enemy spawning ---
obj_game.enemy_spawn_timer = 9999;

// ==========================================
// GAUNTLET MODE
// ==========================================
if (mode == "gauntlet") {
    var wave_count = array_length(gauntlet_waves);

    if (gauntlet_index < wave_count) {
        // Check if current wave is cleared
        var all_dead = true;
        if (gauntlet_spawned) {
            for (var i = 0; i < array_length(gauntlet_active); i++) {
                if (instance_exists(gauntlet_active[i])) {
                    all_dead = false;
                    break;
                }
            }
            if (all_dead) {
                gauntlet_index += 1;
                gauntlet_spawned = false;
                gauntlet_active = [];
                // Clean up any strays (webs, stingers, etc.)
                with (obj_enemy_base) { instance_destroy(); }
                with (obj_web) { instance_destroy(); }
                with (obj_stinger) { instance_destroy(); }
            }
        }

        // Spawn next wave
        if (!gauntlet_spawned && gauntlet_index < wave_count) {
            var wave = gauntlet_waves[gauntlet_index];
            var enemy_obj = wave.enemy;
            var cnt = wave.count;
            gauntlet_active = [];

            // Spawn position — snail spawns at edge so it doesn't instantly die
            var sx_base = room_width / 2;
            var sy = (enemy_obj == obj_snail) ? 32 : room_height / 3;
            var spread = 60;

            // Flies get seesaw pairing
            var shared_axis = irandom(359);

            for (var i = 0; i < cnt; i++) {
                var sx = sx_base + (i - (cnt - 1) / 2) * spread;
                var e = instance_create_layer(sx, sy, "Instances", enemy_obj);
                e.target_x = sx;
                e.target_y = sy;

                if (enemy_obj == obj_spider) {
                    e.web_axis = "vertical";
                    if (instance_exists(e.web)) e.web.axis = "vertical";
                }

                // Pair flies with opposite seesaw phase
                if (enemy_obj == obj_fly) {
                    e.osc_axis = shared_axis;
                    e.osc_phase = i * 180;
                    e.base_x = sx;
                    e.base_y = sy;
                }

                array_push(gauntlet_active, e);
            }

            // Spawn extra enemy type if specified (e.g. bee alongside snail)
            if (variable_struct_exists(wave, "extra")) {
                var ex = instance_create_layer(sx_base + 80, room_height / 3, "Instances", wave.extra);
                ex.target_x = sx_base + 80;
                ex.target_y = room_height / 3;
                array_push(gauntlet_active, ex);
            }

            gauntlet_spawned = true;
        }
    }
}

// ==========================================
// GRID MODE
// ==========================================
if (mode == "grid") {
    var count = array_length(enemy_types);

    if (!grid_spawned) {
        grid_spawned = true;
        var cols = 5;
        var margin_x = 80;
        var margin_y = 80;
        var cell_w = (room_width - margin_x * 2) / (cols - 1);
        var cell_h = (room_height - margin_y * 2) / max(ceil(count / cols) - 1, 1);

        for (var i = 0; i < count; i++) {
            var col = i mod cols;
            var row = i div cols;
            var sx = margin_x + col * cell_w;
            var sy = margin_y + row * cell_h;

            var e = instance_create_layer(sx, sy, "Instances", enemy_types[i]);
            e.target_x = sx;
            e.target_y = sy;
            enemy_instances[i] = e;

            if (enemy_types[i] == obj_spider && instance_exists(e)) {
                e.web_axis = "vertical";
                if (instance_exists(e.web)) e.web.axis = "vertical";
            }
        }
    }

    // Number keys 1-0 toggle
    var key_map = [ord("1"), ord("2"), ord("3"), ord("4"), ord("5"), ord("6"), ord("7"), ord("8"), ord("9"), ord("0")];
    for (var i = 0; i < min(count, 10); i++) {
        if (keyboard_check_pressed(key_map[i])) {
            enemy_enabled[i] = !enemy_enabled[i];
            if (!enemy_enabled[i] && instance_exists(enemy_instances[i])) {
                instance_destroy(enemy_instances[i]);
                enemy_instances[i] = noone;
            } else if (enemy_enabled[i] && !instance_exists(enemy_instances[i])) {
                var cols = 5;
                var margin_x = 80;
                var margin_y = 80;
                var cell_w = (room_width - margin_x * 2) / (cols - 1);
                var cell_h = (room_height - margin_y * 2) / max(ceil(count / cols) - 1, 1);
                var col = i mod cols;
                var row = i div cols;
                var sx = margin_x + col * cell_w;
                var sy = margin_y + row * cell_h;

                var e = instance_create_layer(sx, sy, "Instances", enemy_types[i]);
                e.target_x = sx;
                e.target_y = sy;
                enemy_instances[i] = e;

                if (enemy_types[i] == obj_spider && instance_exists(e)) {
                    e.web_axis = "vertical";
                    if (instance_exists(e.web)) e.web.axis = "vertical";
                }
            }
        }
    }
}
