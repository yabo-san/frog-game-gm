if (ds_list_size(polygon_points) >= 4) {
    draw_set_alpha(0.5);
    
    // Fill meteor using triangle fan from first point
    if (is_meteor) {
        draw_set_color(c_red);
        var cx = polygon_points[| 0];
        var cy = polygon_points[| 1];
        for (var i = 2; i < ds_list_size(polygon_points) - 2; i += 2) {
            draw_triangle_color(
                cx, cy, c_red,
                polygon_points[| i], polygon_points[| i + 1], c_red,
                polygon_points[| i + 2], polygon_points[| i + 3], c_red,
                0.5
            );
        }
    }
    
    // Set outline color
    if (is_meteor) {
        draw_set_color(c_red);
    } else if (is_freeze_zone) {
        draw_set_color(c_aqua);
    } else {
        draw_set_color(c_lime);
    }
    
    // Draw outline
    for (var i = 0; i < ds_list_size(polygon_points) - 2; i += 2) {
        draw_line_width(polygon_points[| i], polygon_points[| i + 1], polygon_points[| i + 2], polygon_points[| i + 3], 3);
    }
    
    // Close the loop
    draw_line_width(
        polygon_points[| ds_list_size(polygon_points) - 2], polygon_points[| ds_list_size(polygon_points) - 1],
        polygon_points[| 0], polygon_points[| 1], 3
    );
    
    draw_set_alpha(1);
}

// Debug text
draw_set_color(c_white);
draw_text(polygon_points[| 0], polygon_points[| 1] - 10, string(lifetime));
if (is_meteor) {
    draw_text(polygon_points[| 0], polygon_points[| 1] - 25, "E:" + string(meteor_enemy_count) + " S:" + string(meteor_stinger_count) + " B:" + string(bounces_remaining));
}