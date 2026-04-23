/// Scorpion — 3D: purple body, maroon claws, stinger lunges toward player
var r = body_radius;
var gz = r;
var stinger_r = enemy_cfg("scorpion", "stinger_radius");

var body_col = eatable ? c_lime : c_purple;
var claw_col = eatable ? c_lime : c_maroon;

// Shadow
circle_3d(x, y, 0, r - 2, c_gray);

// Claws
var claw_dist = r + 8;
var cl_x = x + lengthdir_x(claw_dist, facing_angle + 35);
var cl_y = y + lengthdir_y(claw_dist, facing_angle + 35);
var cr_x = x + lengthdir_x(claw_dist, facing_angle - 35);
var cr_y = y + lengthdir_y(claw_dist, facing_angle - 35);
line_3d(x, y, gz, cl_x, cl_y, gz - 4, 3, claw_col);
circle_3d(cl_x, cl_y, gz - 4, 5, claw_col);
line_3d(x, y, gz, cr_x, cr_y, gz - 4, 3, claw_col);
circle_3d(cr_x, cr_y, gz - 4, 5, claw_col);

// Tail — straight line from body to stinger tip
var tail_segs = 5;
for (var i = 1; i <= tail_segs; i++) {
    var t = i / tail_segs;
    var seg_x = lerp(x, stinger_tip_x, t);
    var seg_y = lerp(y, stinger_tip_y, t);
    var prev_x = lerp(x, stinger_tip_x, (i - 1) / tail_segs);
    var prev_y = lerp(y, stinger_tip_y, (i - 1) / tail_segs);
    line_3d(prev_x, prev_y, gz, seg_x, seg_y, gz, 3, claw_col);
}

// Stinger tip
circle_3d(stinger_tip_x, stinger_tip_y, gz, stinger_r, eatable ? c_yellow : c_red);

// Body (on top)
circle_3d(x, y, gz, r, body_col);

// Eyes
var eye_dist = r * 0.4;
var el_x = x + lengthdir_x(eye_dist, facing_angle + 20);
var el_y = y + lengthdir_y(eye_dist, facing_angle + 20);
var er_x = x + lengthdir_x(eye_dist, facing_angle - 20);
var er_y = y + lengthdir_y(eye_dist, facing_angle - 20);
circle_3d(el_x, el_y, gz + 6, 3, c_white);
circle_3d(er_x, er_y, gz + 6, 3, c_white);
