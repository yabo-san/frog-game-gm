/// @description triangle_3d(x1,y1,z1, x2,y2,z2, x3,y3,z3, color) — draws in current view mode
function triangle_3d(_x1,_y1,_z1, _x2,_y2,_z2, _x3,_y3,_z3, _color) {
    draw_set_color(_color);
    if (global.view_mode != "2d") {
        wp_to_sp(_x1, _y1, _z1);
        var sx1 = res_screen_x, sy1 = res_screen_y;
        wp_to_sp(_x2, _y2, _z2);
        var sx2 = res_screen_x, sy2 = res_screen_y;
        wp_to_sp(_x3, _y3, _z3);
        draw_triangle(sx1, sy1, sx2, sy2, res_screen_x, res_screen_y, false);
    } else {
        draw_triangle(_x1, _y1, _x2, _y2, _x3, _y3, false);
    }
}
