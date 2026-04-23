event_inherited();

points = cfg("enemies.caterpillar.points");
eatable = false;
move_speed = cfg("enemies.caterpillar.move_speed");
reaction_parried = "immune";

// No sprite — custom drawn segments
sprite_normal = -1;
sprite_eatable = -1;

// Segment system — 3 paintable zones
num_segments = cfg("enemies.caterpillar.num_segments");
seg_radius = cfg("enemies.caterpillar.seg_radius");
seg_spacing = cfg("enemies.caterpillar.seg_spacing");

// Track painted state per zone (3 zones across all segments)
// Zone 0 = head, zone 1 = middle, zone 2 = tail
zone_painted = array_create(3, false);
zones_remaining = 3;

// Position history for snake-like body trailing
history_len = num_segments * seg_spacing;
pos_history = array_create(history_len);
for (var i = 0; i < history_len; i++) {
    pos_history[i] = { hx: x, hy: y };
}
history_index = 0;

// Envelope movement — orbit the player
orbit_angle = irandom(359);
orbit_speed = cfg("enemies.caterpillar.orbit_speed");
approach_speed = cfg("enemies.caterpillar.approach_speed");
orbit_radius = cfg("enemies.caterpillar.orbit_radius");
