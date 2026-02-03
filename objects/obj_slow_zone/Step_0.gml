// Only count down if lifetime is positive
if (lifetime > 0) {
    lifetime -= 1;
    if (lifetime <= 0) {
        ds_list_destroy(polygon_points);
        instance_destroy();
        exit;
    }
}
// If lifetime is -1, zone lives forever

// Freeze zones continuously freeze enemies inside
if (is_freeze_zone) {
    with (obj_enemy_base) {
        if (point_in_polygon(x, y, other.polygon_points)) {
            speed_mult = 0;
        }
    }
}