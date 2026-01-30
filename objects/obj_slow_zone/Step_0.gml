// Decrease lifetime
lifetime -= 1;
if (lifetime <= 0) {
    ds_list_destroy(polygon_points);
    instance_destroy();
    exit;
}

// Check all enemies and apply slow effect if inside
with (obj_enemy_base) {
    if (point_in_polygon(x, y, other.polygon_points)) {
        effect = "slow";
        effect_timer = 2;  // Refresh timer (stays slow while in zone)
    }
    // If not inside, let the effect naturally expire
}
