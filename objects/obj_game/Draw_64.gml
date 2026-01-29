draw_set_color(c_white);
draw_text(10, 10, "Score: " + string(global.game_score));
draw_text(10, 30, "Rank: " + string(global.rank));
// draw_text(10, 50, "Pickup Chain: " + string(global.pickup_chain));
draw_text(10, 50, "Combo" + string(global.current_chain));

// Draw brush lines
if (brush_drawing && ds_exists(brush_points, ds_type_list) && ds_list_size(brush_points) >= 4) {
    draw_set_color(c_yellow);
    //draw_set_line_width(3);

    for (var i = 0; i < ds_list_size(brush_points)-2; i += 2) {
        var x1 = brush_points[| i];
        var y1 = brush_points[| i+1];
        var x2 = brush_points[| i+2];
        var y2 = brush_points[| i+3];
        draw_line(x1, y1, x2, y2);
    }
}
// Draw custom crosshair or sprite as cursor
draw_set_color(c_yellow);
draw_line(mouse_clamped_x - 5, mouse_clamped_y, mouse_clamped_x + 5, mouse_clamped_y);
draw_line(mouse_clamped_x, mouse_clamped_y - 5, mouse_clamped_x, mouse_clamped_y + 5);

