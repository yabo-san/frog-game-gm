/// Heavy Bee — 3D: big yellow/black sphere, white wings
var r = body_radius;
var gz = r + 4;

// Shadow
circle_3d(x, y, 0, r - 4, c_gray);

// Wings
circle_3d(x - r - 4, y, gz + r * 0.5, r * 0.6, c_white);
circle_3d(x + r + 4, y, gz + r * 0.5, r * 0.6, c_white);

// Body
if (eatable) {
    circle_3d(x, y, gz, r, c_lime);
} else {
    circle_3d(x, y, gz, r, c_yellow);
    // Stripes as rings
    circle_3d(x, y, gz + r * 0.3, r - 1, c_black);
    circle_3d(x, y, gz + r * 0.15, r - 1, c_yellow);
    circle_3d(x, y, gz - r * 0.1, r - 1, c_black);
    circle_3d(x, y, gz - r * 0.25, r - 1, c_yellow);
}

// Eyes (blue)
circle_3d(x - r * 0.3, y, gz + r * 0.5, r * 0.2, c_aqua);
circle_3d(x + r * 0.3, y, gz + r * 0.5, r * 0.2, c_aqua);

// HP bar
if (!eatable && hp > 0) {
    wp_to_sp(x, y, gz + r + 6);
    draw_set_color(c_red);
    var bar_w = r * 2;
    var hp_ratio = hp / cfg("enemies.heavy_bee.hp");
    draw_rectangle(res_screen_x - r, res_screen_y - 3, res_screen_x - r + bar_w * hp_ratio, res_screen_y, false);
    draw_set_color(c_white);
    draw_rectangle(res_screen_x - r, res_screen_y - 3, res_screen_x + r, res_screen_y, true);
}
