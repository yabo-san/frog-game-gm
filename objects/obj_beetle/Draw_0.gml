/// Beetle — 3D: purple body, dark brown armor front
var r = beetle_radius;
var gz = r;
var armor_broken = (hp <= 0);

// Shadow
circle_3d(x, y, 0, r - 2, c_gray);

// Body (purple)
circle_3d(x, y, gz, r, armor_broken ? c_lime : c_purple);

// Armor cap on front half (dark brown sphere overlay)
if (!armor_broken) {
    var ax = x + lengthdir_x(r * 0.3, facing_angle);
    var ay = y + lengthdir_y(r * 0.3, facing_angle);
    circle_3d(ax, ay, gz + 2, r * 0.8, make_color_rgb(60, 30, 15));

    // Mandibles
    var ml_x = x + lengthdir_x(r + 4, facing_angle + 20);
    var ml_y = y + lengthdir_y(r + 4, facing_angle + 20);
    var mr_x = x + lengthdir_x(r + 4, facing_angle - 20);
    var mr_y = y + lengthdir_y(r + 4, facing_angle - 20);
    line_3d(x, y, gz + 2, ml_x, ml_y, gz, 2, make_color_rgb(80, 40, 20));
    line_3d(x, y, gz + 2, mr_x, mr_y, gz, 2, make_color_rgb(80, 40, 20));
}

// Debug
draw_set_color(c_yellow);
draw_text(x, y + r + 4, state);
