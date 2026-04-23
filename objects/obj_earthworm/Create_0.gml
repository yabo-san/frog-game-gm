event_inherited();

points = enemy_cfg("earthworm", "points");
eatable = enemy_cfg("earthworm", "eatable");
reaction_parried = enemy_cfg("earthworm", "reaction_parried");

sprite_index = global.spr_earthworm_mask;
mask_index = global.spr_earthworm_mask;
sprite_normal = global.spr_earthworm_mask;
sprite_eatable = global.spr_earthworm_mask;

// Spawn indicator phase then short eat window
spawn_delay = enemy_cfg("earthworm", "spawn_delay");
lifetime = enemy_cfg("earthworm", "lifetime");
