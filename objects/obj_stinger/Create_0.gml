// Movement
speed = 2;          // base speed
direction = 0;      // initial direction

// Flags
parried = false;    // has been parried
homing = false;      // should home towards player

// Owner tracking (for limiting active stingers)
owner = noone;      // assigned when spawned

// Optional: lifetime timer to auto-destroy after some frames
lifetime = 600;
