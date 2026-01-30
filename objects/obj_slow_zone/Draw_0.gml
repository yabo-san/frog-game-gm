// Draw the zone outline
if (ds_list_size(polygon_points) >= 4) {
    // Set color based on zone type
    if (is_freeze_zone) {
        draw_set_color(c_aqua);  // Blue for freeze
    } else {
        draw_set_color(c_lime);  // Saturated green for slow
    }
    
    draw_set_alpha(0.5);
    
    for (var i = 0; i < ds_list_size(polygon_points) - 2; i += 2) {
        var x1 = polygon_points[| i];
        var y1 = polygon_points[| i + 1];
        var x2 = polygon_points[| i + 2];
        var y2 = polygon_points[| i + 3];
        draw_line_width(x1, y1, x2, y2, 3);
    }
    
    // Close the loop
    var first_x = polygon_points[| 0];
    var first_y = polygon_points[| 1];
    var last_x = polygon_points[| ds_list_size(polygon_points) - 2];
    var last_y = polygon_points[| ds_list_size(polygon_points) - 1];
    draw_line_width(last_x, last_y, first_x, first_y, 3);
    
    draw_set_alpha(1);
}