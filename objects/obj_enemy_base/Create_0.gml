// Marker to identify all enemies
is_enemy = true;

// How this enemy reacts to a parried stinger
reaction_parried = "damage";

// Eatable system
eatable = false;
sprite_normal = -1;
sprite_eatable = -1;

// Default properties (children can override)
hp = cfg("enemies.base.hp");
points = cfg("enemies.base.points");
speed_mult = 1;
move_speed = cfg("enemies.base.move_speed");

// Target (for off-screen spawning)
target_x = noone;
target_y = noone;

// Slow tagging system
slow_level = 0;
slow_timer = 0;
vulnerability_timer = 0;
slow_duration = cfg("enemies.slow_duration");
vulnerability_duration = cfg("enemies.vulnerability_duration");