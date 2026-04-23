event_inherited();

points = cfg("enemies.earthworm.points");
eatable = true;
move_speed = cfg("enemies.earthworm.move_speed");
reaction_parried = "damage";

sprite_index = global.spr_earthworm_mask;
mask_index = global.spr_earthworm_mask;
sprite_normal = global.spr_earthworm_mask;
sprite_eatable = global.spr_earthworm_mask;

// Timed — disappears after window expires
lifetime = cfg("enemies.earthworm.lifetime");

// Erratic fleeing movement
move_direction = irandom(359);
wiggle_offset = 0;
