/// Snail — 3D: teal body on ground, brown shell sphere on top
var gz = 6;
var teal = eatable ? c_orange : make_color_rgb(60, 160, 150);
var shell_col = eatable ? c_yellow : make_color_rgb(120, 80, 40);
var shell_inner = eatable ? c_orange : make_color_rgb(90, 60, 30);

// Shadow
circle_3d(x, y, 0, 8, c_gray);

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
