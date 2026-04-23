/// Test Gym — debug room controller

// --- Gauntlet mode: sequential wave test ---
// Kill all enemies in a wave, the next wave spawns.
gauntlet_waves = [
    { enemy: obj_fly, count: 2, name: "fly x2" },
    { enemy: obj_bee, count: 1, name: "bee" },
    { enemy: obj_spider, count: 1, name: "spider" },
    { enemy: obj_beetle, count: 1, name: "beetle" },
    { enemy: obj_heavy_bee, count: 1, name: "heavy_bee" },
    { enemy: obj_scorpion, count: 1, name: "scorpion" },
    { enemy: obj_caterpillar, count: 1, name: "caterpillar" },
    { enemy: obj_butterfly, count: 1, name: "butterfly" },
    { enemy: obj_earthworm, count: 1, name: "earthworm" },
    { enemy: obj_snail, count: 1, name: "snail + bee", extra: obj_bee },
];
gauntlet_index = 0;
gauntlet_active = [];  // array of instance refs
gauntlet_spawned = false;

// Kill normal spawner immediately (before first Step)
obj_game.enemy_spawn_timer = 999999;

// State
enemies_frozen = false;
mode = "gauntlet";  // "gauntlet" or "grid"

// Grid mode data
enemy_types = [obj_bee, obj_fly, obj_snail, obj_beetle, obj_butterfly, obj_spider, obj_caterpillar, obj_scorpion, obj_heavy_bee, obj_earthworm];
enemy_names = ["bee", "fly", "snail", "beetle", "butterfly", "spider", "caterpillar", "scorpion", "heavy_bee", "earthworm"];
enemy_enabled = array_create(array_length(enemy_types), true);
enemy_instances = array_create(array_length(enemy_types), noone);
grid_spawned = false;
