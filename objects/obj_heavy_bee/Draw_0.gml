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
    circle_3d(x, y, gz + r * 0.3, r - 1, c_black);
    circle_3d(x, y, gz + r * 0.15, r - 1, c_yellow);
    circle_3d(x, y, gz - r * 0.1, r - 1, c_black);
    circle_3d(x, y, gz - r * 0.25, r - 1, c_yellow);
}

// Eyes (blue)
circle_3d(x - r * 0.3, y, gz + r * 0.5, r * 0.2, c_aqua);
circle_3d(x + r * 0.3, y, gz + r * 0.5, r * 0.2, c_aqua);
