event_inherited();
points = enemy_cfg("bee", "points");
eatable = enemy_cfg("bee", "eatable");
reaction_parried = enemy_cfg("bee", "reaction_parried");
can_fire = true;
fire_cooldown = enemy_cfg("bee", "fire_cooldown");
fire_timer = 0;
max_active_stingers = enemy_cfg("bee", "max_active_stingers");

sprite_index = global.spr_bee_mask;
mask_index = global.spr_bee_mask;
sprite_normal = global.spr_bee_mask;
sprite_eatable = global.spr_bee_mask;

//copy from fly for movement:
// Random movement timer
move_timer = irandom_range(60, 120);  // frames to move in current direction
stop_timer = 0;                       // frames to pause after moving

// Random direction in degrees (0–359)
move_direction = irandom(359);