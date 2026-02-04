ds_list_destroy(brush_points);
for (var i = 0; i < ds_list_size(active_walls); i++) {
    ds_list_destroy(active_walls[| i].frozen_stingers);
}
ds_list_destroy(active_walls);