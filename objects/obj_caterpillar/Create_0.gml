event_inherited();

points = enemy_cfg("caterpillar", "points");
eatable = enemy_cfg("caterpillar", "eatable");
move_speed = enemy_cfg("caterpillar", "move_speed");
reaction_parried = enemy_cfg("caterpillar", "reaction_parried");

// No sprite — custom drawn segments
sprite_normal = -1;
sprite_eatable = -1;

// Segment system — paintable zones
num_segments = enemy_cfg("caterpillar", "num_segments");
seg_radius = enemy_cfg("caterpillar", "seg_radius");
seg_spacing = enemy_cfg("caterpillar", "seg_spacing");

// Track painted state per zone (head / middle / tail)
var _zones = enemy_cfg("caterpillar", "zones_required");
zone_painted = array_create(_zones, false);
zones_remaining = _zones;

// Position history for snake-like body trailing
history_len = num_segments * seg_spacing;
pos_history = array_create(history_len);
for (var i = 0; i < history_len; i++) {
    pos_history[i] = { hx: x, hy: y };
}
history_index = 0;

// Envelope movement — orbit the player
orbit_angle = irandom(359);
orbit_speed = enemy_cfg("caterpillar", "orbit_speed");
approach_speed = enemy_cfg("caterpillar", "approach_speed");
orbit_radius = enemy_cfg("caterpillar", "orbit_radius");
