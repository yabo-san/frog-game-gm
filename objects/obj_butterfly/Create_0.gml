event_inherited();

hp = cfg("enemies.butterfly.hp");
points = cfg("enemies.butterfly.points");
move_speed = cfg("enemies.butterfly.move_speed");
eatable = false;

sprite_normal = global.spr_butterfly;
sprite_eatable = global.spr_butterfly_eatable;
sprite_index = sprite_normal;

reaction_parried = "damage";

// Erratic flutter movement
move_timer = irandom_range(30, 60);
stop_timer = 0;
move_direction = irandom(359);
flutter_offset = 0;
