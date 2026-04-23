event_inherited();

points = enemy_cfg("beetle", "points");
eatable = enemy_cfg("beetle", "eatable");
reaction_parried = enemy_cfg("beetle", "reaction_parried");

// Use generated placeholder sprite for collision mask
sprite_index = global.spr_beetle;
sprite_normal = global.spr_beetle;
sprite_eatable = global.spr_beetle;

// Facing / rotation
facing_angle = irandom(359);
turn_speed = enemy_cfg("beetle", "turn_speed");

// State machine: "aim" or "charge"
state = "aim";
aim_timer = enemy_cfg("beetle", "aim_time");
charge_speed = enemy_cfg("beetle", "charge_speed");
charge_duration = enemy_cfg("beetle", "charge_duration");
charge_timer = 0;

// Drawing
beetle_radius = enemy_cfg("beetle", "radius");
