/// Fly — 3D: light blue body, white wings, red eyes, hovering
var gz = 16;
var body_col = eatable ? c_lime : make_color_rgb(100, 180, 220);

// Shadow
circle_3d(x, y, 0, 5, c_gray);

// Wings
circle_3d(x - 6, y, gz + 6, 5, c_white);
circle_3d(x + 6, y, gz + 6, 5, c_white);

// Body
circle_3d(x, y, gz, 8, body_col);

// Eyes
circle_3d(x - 3, y, gz + 5, 2, make_color_rgb(255, 80, 80));
circle_3d(x + 3, y, gz + 5, 2, make_color_rgb(255, 80, 80));
