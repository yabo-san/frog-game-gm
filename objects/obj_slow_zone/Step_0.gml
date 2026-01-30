lifetime -= 1;
if (lifetime <= 0) {
    ds_list_destroy(polygon_points);
    instance_destroy();
    exit;
}

// Freeze zones set enemies to 0 speed
if (is_freeze_zone) {
    with (obj_enemy_base) {
        if (point_in_polygon(x, y, other.polygon_points)) {
            speed_mult = 0;  // Frozen
        }
    }
}