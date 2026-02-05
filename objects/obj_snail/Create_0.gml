event_inherited();
//hp = 1;                          // Snail starts with 1 HP
points = cfg("enemies.snail.points");
move_speed = cfg("enemies.snail.move_speed");
reaction_parried = "eatable";     // Parried stinger sets eatable instead of killing

sprite_normal = spr_snail;
sprite_eatable = spr_snail_eatable;

eatable = false;                 // Start not eatable
