event_inherited();

hp = enemy_cfg("butterfly", "hp");
points = enemy_cfg("butterfly", "points");
move_speed = enemy_cfg("butterfly", "move_speed");
eatable = enemy_cfg("butterfly", "eatable");
reaction_parried = enemy_cfg("butterfly", "reaction_parried");

sprite_normal = global.spr_butterfly;
sprite_eatable = global.spr_butterfly_eatable;
sprite_index = sprite_normal;

// Erratic flutter movement
move_timer = irandom_range(30, 60);
stop_timer = 0;
move_direction = irandom(359);
flutter_offset = 0;
