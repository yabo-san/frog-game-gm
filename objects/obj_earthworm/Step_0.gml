event_inherited();

// Spawn indicator phase — not eatable yet, just pulsing green circle
if (spawn_delay > 0) {
    spawn_delay -= speed_mult;
    eatable = false;
    exit;
}

// Now eatable and ticking down
eatable = true;
lifetime -= speed_mult;
if (lifetime <= 0) {
    instance_destroy();
    exit;
}
