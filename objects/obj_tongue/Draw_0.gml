/// Tongue — 3D red line from frog to tip
if (!instance_exists(frog)) exit;

var gz = 12; // match frog body height

// Tongue line
line_3d(frog.x, frog.y, gz, x, y, 6, 4, c_red);

// Tongue tip bulb
circle_3d(x, y, 6, 5, make_color_rgb(200, 50, 50));
