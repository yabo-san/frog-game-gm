event_inherited();

points = enemy_cfg("scorpion", "points");
eatable = enemy_cfg("scorpion", "eatable");
move_speed = enemy_cfg("scorpion", "move_speed");
reaction_parried = enemy_cfg("scorpion", "reaction_parried");

sprite_normal = -1;
sprite_eatable = -1;

// Body dimensions
body_radius = enemy_cfg("scorpion", "body_radius");

// Circle strafe
orbit_angle = irandom(359);
orbit_speed = enemy_cfg("scorpion", "orbit_speed");
orbit_radius = enemy_cfg("scorpion", "orbit_radius");
facing_angle = 0;  // direction scorpion faces (toward player)

// Stinger tail
tail_length = enemy_cfg("scorpion", "tail_length");
stinger_tip_x = x;
stinger_tip_y = y;

// Lunge system
state = "strafe";
lunge_cooldown = enemy_cfg("scorpion", "lunge_cooldown");
lunge_timer = lunge_cooldown;
lunge_speed = enemy_cfg("scorpion", "lunge_speed");
lunge_duration = enemy_cfg("scorpion", "lunge_duration");
lunge_charge_timer = 0;
lunge_target_x = x;
lunge_target_y = y;
lunge_extend = 0;  // how far the stinger has extended (0 to 1)

// Stun
stun_timer = 0;
stun_duration = enemy_cfg("scorpion", "stun_duration");
