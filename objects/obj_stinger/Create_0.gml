// Movement
speed = 5;          // base speed
direction = 0;      // initial direction

// Flags
parried = false;    // has been parried
homing = true;      // should home towards player

// Owner tracking (for limiting active stingers)
owner = noone;      // assigned when spawned

// Optional: lifetime timer to auto-destroy after some frames
lifetime = 600;
