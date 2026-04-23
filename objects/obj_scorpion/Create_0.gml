event_inherited();

points = cfg("enemies.scorpion.points");
eatable = false;
move_speed = cfg("enemies.scorpion.move_speed");
reaction_parried = "immune";

sprite_normal = -1;
sprite_eatable = -1;

// Body dimensions
body_radius = cfg("enemies.scorpion.body_radius");

// Circle strafe
orbit_angle = irandom(359);
orbit_speed = cfg("enemies.scorpion.orbit_speed");
orbit_radius = cfg("enemies.scorpion.orbit_radius");
facing_angle = 0;  // direction scorpion faces (toward player)

// Stinger tail
tail_length = cfg("enemies.scorpion.tail_length");
stinger_tip_x = x;
stinger_tip_y = y;

// Lunge system
state = "strafe";
lunge_cooldown = cfg("enemies.scorpion.lunge_cooldown");
lunge_timer = lunge_cooldown;
lunge_speed = cfg("enemies.scorpion.lunge_speed");
lunge_duration = cfg("enemies.scorpion.lunge_duration");
lunge_charge_timer = 0;
lunge_target_x = x;
lunge_target_y = y;
lunge_extend = 0;  // how far the stinger has extended (0 to 1)

// Stun
stun_timer = 0;
stun_duration = cfg("enemies.scorpion.stun_duration");
