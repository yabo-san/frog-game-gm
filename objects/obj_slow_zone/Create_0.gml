polygon_points = ds_list_create();
is_freeze_zone = false;

if (is_freeze_zone) {
    lifetime = 300;  // Freeze zones last 5 seconds
} else {
    lifetime = 15;   // Slow zones disappear after 1 second
}

zone_color = c_lime;  // Default green for slow zones