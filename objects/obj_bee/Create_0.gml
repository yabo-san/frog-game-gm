event_inherited();
points = cfg("enemies.bee.points");
can_fire = true;       // ready to fire
fire_cooldown = 120;   // frames between shots
fire_timer = 0;        // counts down when on cooldown
max_active_stingers = 1; // max stingers allowed at once
eatable = true
reaction_parried = "immune"; // cannot be affected by stingers

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