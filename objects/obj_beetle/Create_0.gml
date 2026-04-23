event_inherited();

points = cfg("enemies.beetle.points");
eatable = false;
reaction_parried = "damage";

// Use generated placeholder sprite for collision mask
sprite_index = global.spr_beetle;
sprite_normal = global.spr_beetle;
sprite_eatable = global.spr_beetle;

// Facing / rotation
facing_angle = irandom(359);
turn_speed = cfg("enemies.beetle.turn_speed");

// State machine: "aim" or "charge"
state = "aim";
aim_timer = cfg("enemies.beetle.aim_time");
charge_speed = cfg("enemies.beetle.charge_speed");
charge_duration = cfg("enemies.beetle.charge_duration");
charge_timer = 0;

// Drawing
beetle_radius = cfg("enemies.beetle.radius");
