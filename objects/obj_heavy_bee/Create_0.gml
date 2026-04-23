event_inherited();

hp = cfg("enemies.heavy_bee.hp");
points = cfg("enemies.heavy_bee.points");
eatable = false;  // needs to be damaged down first
reaction_parried = "damage";

// Larger collision mask
sprite_index = global.spr_heavy_bee_mask;
mask_index = global.spr_heavy_bee_mask;
sprite_normal = global.spr_heavy_bee_mask;
sprite_eatable = global.spr_heavy_bee_mask;

// Firing — more stingers, faster
can_fire = true;
fire_cooldown = cfg("enemies.heavy_bee.fire_cooldown");
fire_timer = 0;
max_active_stingers = cfg("enemies.heavy_bee.max_stingers");

// Movement — same random walk but slower (big and heavy)
move_speed = cfg("enemies.heavy_bee.move_speed");
move_timer = irandom_range(60, 120);
stop_timer = 0;
move_direction = irandom(359);

// Visual scale
body_radius = cfg("enemies.heavy_bee.body_radius");
