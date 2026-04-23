/// @description circle_3d(x, y, z, radius, color) — draws in current view mode
function circle_3d(_x, _y, _z, _radius, _color) {
    draw_set_color(_color);
    if (global.view_mode != "2d") {
        wp_to_sp(_x, _y, _z);
        if (res_screen_scale > 0) {
            draw_circle(res_screen_x, res_screen_y, _radius * res_screen_scale, false);
        }
    } else {
        // Top-down: ignore z, draw flat
        draw_circle(_x, _y, _radius, false);
    }
}
