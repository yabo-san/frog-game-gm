lifetime -= 1;
if (lifetime <= 0) {
    ds_list_destroy(polygon_points);
    instance_destroy();
}