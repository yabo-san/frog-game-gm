/// Earthworm — 3D: small green segmented worm on the ground
var seg_count = 5;
var seg_r = 4;
var seg_gap = 7;
var gz = seg_r + 1;

// Flash when about to disappear
var visible_draw = true;
if (lifetime < 90 && (floor(lifetime / 6) mod 2 == 0)) {
    visible_draw = false;
}

if (visible_draw) {
    for (var i = seg_count - 1; i >= 0; i--) {
        var sx = x - lengthdir_x(i * seg_gap, move_direction);
        var sy = y - lengthdir_y(i * seg_gap, move_direction);

        circle_3d(sx, sy, 0, seg_r - 1, c_gray); // shadow
        circle_3d(sx, sy, gz, seg_r, (i == 0) ? c_lime : c_green);
    }

    // Eyes
    circle_3d(x, y, gz + 3, 1, c_black);
}

// Timer bar (stays 2D on GUI since it's HUD-like)
wp_to_sp(x, y, gz + 10);
draw_set_color(c_lime);
var bar_w = 20 * (lifetime / cfg("enemies.earthworm.lifetime"));
draw_rectangle(res_screen_x - 10, res_screen_y - 4, res_screen_x - 10 + bar_w, res_screen_y - 1, false);
draw_set_color(c_white);
draw_rectangle(res_screen_x - 10, res_screen_y - 4, res_screen_x + 10, res_screen_y - 1, true);
