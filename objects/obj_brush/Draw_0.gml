// Draw brush trail
if (brush_drawing && ds_exists(brush_points, ds_type_list) && ds_list_size(brush_points) >= 4) {
    draw_set_color(c_yellow);
    for (var i = 0; i < ds_list_size(brush_points) - 2; i += 2) {
        draw_line(brush_points[| i], brush_points[| i + 1], 
                 brush_points[| i + 2], brush_points[| i + 3]);
    }
}

// Draw walls
draw_set_color(c_yellow);
for (var i = 0; i < ds_list_size(active_walls); i++) {
    var wall = active_walls[| i];
    draw_line_width(wall.x1, wall.y1, wall.x2, wall.y2, 4);
}

draw_set_color(c_white);