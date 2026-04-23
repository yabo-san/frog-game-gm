/// Frog — 3D: green body sphere, yellow eyes, sits on ground
// Don't draw self in first person (commented out, FP disabled)
// if (global.view_mode == "fp") exit;

var gz = 12; // body height off ground

// Shadow
circle_3d(x, y, 0, 10, c_gray);

// Body
circle_3d(x, y, gz, 12, c_green);

// Belly
circle_3d(x, y, gz - 2, 8, c_lime);

// Eyes (on top)
circle_3d(x - 4, y, gz + 10, 5, c_yellow);
circle_3d(x + 4, y, gz + 10, 5, c_yellow);
// Pupils
circle_3d(x - 4, y, gz + 11, 2, c_black);
circle_3d(x + 4, y, gz + 11, 2, c_black);
