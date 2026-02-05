event_inherited();
points = cfg("enemies.fly.points");
eatable = true;           // always eatable from the start
sprite_normal = spr_fly;
sprite_eatable = spr_fly_eatable;

// Movement
move_speed = cfg("enemies.fly.move_speed");
speed_mult = 1;

// Random movement timer
move_timer = irandom_range(60, 120);  // frames to move in current direction
stop_timer = 0;                       // frames to pause after moving

// Random direction in degrees (0–359)
move_direction = irandom(359);
