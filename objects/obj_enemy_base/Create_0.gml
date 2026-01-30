// Marker to identify all enemies (including children)
is_enemy = true;

// How this enemy reacts to a parried stinger
// Options: "eatable", "damage", "immune"
reaction_parried = "damage";

// Eatable system
eatable = false;
sprite_normal = -1 //s_enemy_placeholder;
sprite_eatable = -1 //s_enemy_placeholder_eat;

// Default properties
hp = 1;
points = 10;
effect = "";
effect_timer = 0;
speed_mult = 1;

slow_stacks = 0;


// Target (for off-screen spawning)
target_x = noone;
target_y = noone;

move_speed = 1; // default value