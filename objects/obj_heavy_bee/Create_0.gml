event_inherited();

hp = enemy_cfg("heavy_bee", "hp");
points = enemy_cfg("heavy_bee", "points");
eatable = enemy_cfg("heavy_bee", "eatable");
reaction_parried = enemy_cfg("heavy_bee", "reaction_parried");

sprite_index = global.spr_heavy_bee_mask;
mask_index = global.spr_heavy_bee_mask;
sprite_normal = global.spr_heavy_bee_mask;
sprite_eatable = global.spr_heavy_bee_mask;

// Burst fire
can_fire = true;
fire_cooldown = enemy_cfg("heavy_bee", "fire_cooldown");
fire_timer = 0;

// Movement — straight toward player
move_speed = enemy_cfg("heavy_bee", "move_speed");

body_radius = enemy_cfg("heavy_bee", "body_radius");
