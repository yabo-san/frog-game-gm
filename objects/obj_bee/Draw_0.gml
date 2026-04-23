/// Bee — 3D: yellow/black body, white wings, blue eyes
var gz = 18; // bees hover high

// Shadow
circle_3d(x, y, 0, 6, c_gray);

// Wings
circle_3d(x - 8, y, gz + 8, 6, c_white);
circle_3d(x + 8, y, gz + 8, 6, c_white);

// Body
circle_3d(x, y, gz, 10, c_yellow);

// Stripes (draw as smaller dark circles overlapping)
circle_3d(x, y, gz + 3, 9, c_black);
circle_3d(x, y, gz + 1, 9, c_yellow);
circle_3d(x, y, gz - 2, 9, c_black);
circle_3d(x, y, gz - 4, 9, c_yellow);

// Eyes (blue)
circle_3d(x - 3, y, gz + 6, 2, c_aqua);
circle_3d(x + 3, y, gz + 6, 2, c_aqua);
