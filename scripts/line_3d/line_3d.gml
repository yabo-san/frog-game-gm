/// @description line_3d(x1, y1, z1, x2, y2, z2, width, color) — draws in current view mode
function line_3d(_x1, _y1, _z1, _x2, _y2, _z2, _width, _color) {
    draw_set_color(_color);
    if (global.view_mode != "2d") {
        wp_to_sp(_x1, _y1, _z1);
        var sx1 = res_screen_x, sy1 = res_screen_y, s1 = res_screen_scale;
        wp_to_sp(_x2, _y2, _z2);
        if (s1 > 0 || res_screen_scale > 0) {
            draw_line_width(sx1, sy1, res_screen_x, res_screen_y, _width * (s1 + res_screen_scale) / 2);
        }
    } else {
        draw_line_width(_x1, _y1, _x2, _y2, _width);
    }
}
