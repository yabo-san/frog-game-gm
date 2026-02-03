// Marker to identify all enemies (including children)
is_enemy = true;

// How this enemy reacts to a parried stinger
// Options: "eatable", "damage", "immune"
reaction_parried = "damage";

// Eatable system
eatable = false;
sprite_normal = -1;
sprite_eatable = -1;

// Default properties
hp = 1;
points = 10;
speed_mult = 1;
move_speed = 1;

// Target (for off-screen spawning)
target_x = noone;
target_y = noone;

// Slow tagging system (NEW)
slow_level = 0;              // 0, 1, 2, or 3 (frozen)
slow_timer = 0;              // Active slow duration
vulnerability_timer = 0;     // Window to receive next tag
slow_duration = 180;         // 3 seconds (at 60fps)
vulnerability_duration = 120; // 2 seconds window