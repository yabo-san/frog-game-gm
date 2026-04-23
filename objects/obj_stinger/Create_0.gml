sprite_index = global.spr_stinger_mask;
mask_index = global.spr_stinger_mask;

// Movement
speed = 1;          // base speed
direction = 0;      // initial direction

// Flags
parried = false;    // has been parried
homing = false;      // should home towards player

// Owner tracking (for limiting active stingers)
owner = noone;      // assigned when spawned

// Optional: lifetime timer to auto-destroy after some frames
lifetime = 600;

frozen_speed = 0;  // Store speed before freezing
heavy = false;     // set true by heavy bee for larger stingers