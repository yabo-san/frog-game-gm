event_inherited();
points = enemy_cfg("fly", "points");
eatable = enemy_cfg("fly", "eatable");
sprite_index = global.spr_fly_mask;
mask_index = global.spr_fly_mask;
sprite_normal = global.spr_fly_mask;
sprite_eatable = global.spr_fly_mask;

// Movement
move_speed = enemy_cfg("fly", "move_speed");
speed_mult = 1;

// Seesaw oscillation — paired flies share axis but opposite phase
osc_timer = 0;
osc_phase = 0;              // 0 or 180 — set by spawner for pairing
osc_axis = irandom(359);    // axis to seesaw along — set by spawner for pairing
osc_amplitude = 70;
osc_speed = 2.5;
drift_speed = 0.3;
base_x = x;
base_y = y;
