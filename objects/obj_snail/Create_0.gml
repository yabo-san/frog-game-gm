event_inherited();
//hp = 1;                          // Snail starts with 1 HP
points = cfg("enemies.snail.points");
move_speed = cfg("enemies.snail.move_speed");
reaction_parried = "eatable";     // Parried stinger sets eatable instead of killing

sprite_index = global.spr_snail_mask;
mask_index = global.spr_snail_mask;
sprite_normal = global.spr_snail_mask;
sprite_eatable = global.spr_snail_mask;

eatable = false;                 // Start not eatable
