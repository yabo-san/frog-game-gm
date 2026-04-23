/// Snail — 3D: teal body, brown shell. Hides in shell when hit by tongue.
var gz = 6;
var teal = make_color_rgb(60, 160, 150);
var shell_col = make_color_rgb(120, 80, 40);
var shell_inner = make_color_rgb(90, 60, 30);

// Shadow
circle_3d(x, y, 0, 8, c_gray);

if (in_shell) {
    // Shell only — body hidden, shell on ground
    circle_3d(x, y, gz + 4, 12, shell_col);
    circle_3d(x, y, gz + 5, 8, shell_inner);
    circle_3d(x, y, gz + 6, 4, shell_col);
} else {
    // Body (low, on ground)
    circle_3d(x - 4, y, gz, 7, teal);

    // Shell (sphere sitting on top/behind)
    circle_3d(x + 4, y, gz + 8, 10, shell_col);
    circle_3d(x + 4, y, gz + 9, 6, shell_inner);
    circle_3d(x + 4, y, gz + 10, 3, shell_col);

    // Eye stalks
    line_3d(x - 6, y, gz + 3, x - 8, y, gz + 10, 2, teal);
    line_3d(x - 2, y, gz + 3, x, y, gz + 10, 2, teal);
    circle_3d(x - 8, y, gz + 10, 2, c_black);
    circle_3d(x, y, gz + 10, 2, c_black);
}
