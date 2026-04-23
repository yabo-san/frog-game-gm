/// Fly — 3D: black body, gray wings, red eyes, hovering
var gz = 16; // flies hover higher

// Shadow
circle_3d(x, y, 0, 5, c_gray);

// Wings
circle_3d(x - 6, y, gz + 6, 5, c_gray);
circle_3d(x + 6, y, gz + 6, 5, c_gray);

// Body
circle_3d(x, y, gz, 8, c_black);

// Eyes
circle_3d(x - 3, y, gz + 5, 2, make_color_rgb(255, 80, 80));
circle_3d(x + 3, y, gz + 5, 2, make_color_rgb(255, 80, 80));
