/// Stinger — 3D orange triangle
var gz = 10;
var len = heavy ? 20 : 14;
var wid = heavy ? 10 : 7;
var col = parried ? c_yellow : c_orange;

var tip_x = x + lengthdir_x(len, direction);
var tip_y = y + lengthdir_y(len, direction);
var l_x = x + lengthdir_x(wid, direction + 140);
var l_y = y + lengthdir_y(wid, direction + 140);
var r_x = x + lengthdir_x(wid, direction - 140);
var r_y = y + lengthdir_y(wid, direction - 140);

triangle_3d(tip_x, tip_y, gz, l_x, l_y, gz, r_x, r_y, gz, col);

// Outline
line_3d(tip_x, tip_y, gz, l_x, l_y, gz, 1, make_color_rgb(180, 100, 20));
line_3d(l_x, l_y, gz, r_x, r_y, gz, 1, make_color_rgb(180, 100, 20));
line_3d(r_x, r_y, gz, tip_x, tip_y, gz, 1, make_color_rgb(180, 100, 20));
