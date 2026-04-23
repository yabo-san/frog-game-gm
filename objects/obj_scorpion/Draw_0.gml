/// Scorpion — 3D: purple body, maroon claws, tail with stinger
var r = body_radius;
var gz = r;

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

// Tail segments
var tail_base_angle = facing_angle + 180;
var prev_tx = x + lengthdir_x(r, tail_base_angle);
var prev_ty = y + lengthdir_y(r, tail_base_angle);
var prev_tz = gz;
var tail_segs = 5;
for (var i = 1; i <= tail_segs; i++) {
    var t = i / tail_segs;
    var seg_angle = lerp(tail_base_angle, point_direction(x, y, stinger_tip_x, stinger_tip_y), t);
    var seg_dist = lerp(r, point_distance(x, y, stinger_tip_x, stinger_tip_y), t);
    var seg_x = x + lengthdir_x(seg_dist, seg_angle);
    var seg_y = y + lengthdir_y(seg_dist, seg_angle);
    var seg_z = gz + sin(t * pi) * 20; // arc up
    line_3d(prev_tx, prev_ty, prev_tz, seg_x, seg_y, seg_z, 3, claw_col);
    prev_tx = seg_x; prev_ty = seg_y; prev_tz = seg_z;
}

// Stinger tip
circle_3d(stinger_tip_x, stinger_tip_y, gz + 10, 4, eatable ? c_yellow : c_red);

// Body
circle_3d(x, y, gz, r, body_col);

// Eyes
var eye_dist = r * 0.4;
var el_x = x + lengthdir_x(eye_dist, facing_angle + 20);
var el_y = y + lengthdir_y(eye_dist, facing_angle + 20);
var er_x = x + lengthdir_x(eye_dist, facing_angle - 20);
var er_y = y + lengthdir_y(eye_dist, facing_angle - 20);
circle_3d(el_x, el_y, gz + 6, 3, c_white);
circle_3d(er_x, er_y, gz + 6, 3, c_white);

// Debug
draw_set_color(c_yellow);
draw_text(x, y + r + 4, state);
