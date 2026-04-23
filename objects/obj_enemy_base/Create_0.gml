// Marker to identify all enemies
is_enemy = true;

// Defaults from base config (children override via enemy_cfg)
eatable = cfg("enemies.base.eatable");
reaction_parried = cfg("enemies.base.reaction_parried");
sprite_normal = -1;
sprite_eatable = -1;

hp = cfg("enemies.base.hp");
points = cfg("enemies.base.points");
speed_mult = 1;
move_speed = cfg("enemies.base.move_speed");
contact_damage = cfg("enemies.base.contact_damage");

// Target (for off-screen spawning)
target_x = noone;
target_y = noone;

// Slow tagging system
slow_level = 0;
slow_timer = 0;
vulnerability_timer = 0;
slow_duration = cfg("enemies.slow_duration");
vulnerability_duration = cfg("enemies.vulnerability_duration");