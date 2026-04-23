/// Spider — 3D: dark body sphere, thick legs, red eyes
var r = 20;
var gz = r;
var body_col = eatable ? c_lime : make_color_rgb(50, 30, 20);
var leg_col = eatable ? c_lime : make_color_rgb(40, 25, 15);

// Shadow
circle_3d(x, y, 0, r - 4, c_gray);

// Legs
var leg_len = r + 10;
for (var i = 0; i < 8; i++) {
    var la = i * 45;
    var lx = x + lengthdir_x(leg_len, la);
    var ly = y + lengthdir_y(leg_len, la);
    // Leg goes down to ground then out
    line_3d(x, y, gz, lx, ly, 0, 3, leg_col);
}

// Body
circle_3d(x, y, gz, r, body_col);

// Eyes
circle_3d(x - 6, y, gz + 8, 3, make_color_rgb(255, 60, 60));
circle_3d(x + 6, y, gz + 8, 3, make_color_rgb(255, 60, 60));
