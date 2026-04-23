/// Butterfly — 3D: purple body, fuchsia wings spread out
var gz = 20;

// Shadow
circle_3d(x, y, 0, 8, c_gray);

// Wings (spread left/right)
var wing_col = eatable ? c_yellow : c_fuchsia;
circle_3d(x - 16, y, gz + 4, 10, wing_col);
circle_3d(x + 16, y, gz + 4, 10, wing_col);

// Body (narrow center)
var body_col = eatable ? c_lime : c_purple;
circle_3d(x, y, gz, 6, body_col);

// Eyes
circle_3d(x - 2, y, gz + 5, 2, c_black);
circle_3d(x + 2, y, gz + 5, 2, c_black);
