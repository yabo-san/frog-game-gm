if (ds_list_size(polygon_points) >= 4) {
    draw_set_alpha(0.7);
    draw_set_color(c_white);
    
    // Fill with white
    draw_primitive_begin(pr_trianglefan);
    for (var i = 0; i < ds_list_size(polygon_points); i += 2) {
        draw_vertex(polygon_points[| i], polygon_points[| i + 1]);
    }
    draw_primitive_end();
    
    draw_set_alpha(1);
}