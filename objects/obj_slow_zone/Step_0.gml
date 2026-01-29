// Decrease lifetime (optional)
lifetime -= 1;
if (lifetime <= 0) {
    ds_list_destroy(polygon_points);
    instance_destroy();
    exit;
}

// Check all enemies and slow them if inside
with (obj_enemy_base) {
    if (point_in_polygon(x, y, other.polygon_points)) {
        speed_mult = 0.3;  // 30% speed when inside
    } else {
        speed_mult = 1.0;  // Normal speed when outside
    }
}