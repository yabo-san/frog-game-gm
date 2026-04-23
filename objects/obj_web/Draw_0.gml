/// Web — 3D white line across screen at height
if (!instance_exists(spider)) exit;

var gz = 12;
var wx1, wy1, wx2, wy2;
if (axis == "vertical") {
    wx1 = x; wy1 = 0;
    wx2 = x; wy2 = room_height;
} else {
    wx1 = 0; wy1 = y;
    wx2 = room_width; wy2 = y;
}

draw_set_alpha(0.7);
line_3d(wx1, wy1, gz, wx2, wy2, gz, web_width, c_white);
draw_set_alpha(1.0);
