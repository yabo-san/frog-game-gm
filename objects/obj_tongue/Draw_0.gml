/// Tongue — chain chomp style: chain links from frog to a chomping head
if (!instance_exists(frog)) exit;

var gz = 12;
var tip_gz = 8;
var dist = point_distance(frog.x, frog.y, x, y);
var dir = point_direction(frog.x, frog.y, x, y);

// --- Chain links ---
var link_spacing = 8;
var link_count = floor(dist / link_spacing);
var link_r = 3;

for (var i = 1; i < link_count; i++) {
    var t = i / max(link_count, 1);
    var lx = lerp(frog.x, x, t);
    var ly = lerp(frog.y, y, t);
    var lz = lerp(gz, tip_gz, t);

    // Alternating dark/light for chain link look
    var col = (i mod 2 == 0) ? make_color_rgb(60, 60, 60) : make_color_rgb(40, 40, 40);
    circle_3d(lx, ly, lz, link_r, col);
}

// --- Chomp head (at tongue tip) ---
var head_r = 10;
var mouth_open = moving && !retracting;

// Head body — dark sphere
circle_3d(x, y, tip_gz, head_r, make_color_rgb(30, 30, 35));

// Highlight/sheen on top
circle_3d(x - 2, y - 2, tip_gz + 4, head_r * 0.5, make_color_rgb(70, 70, 80));

if (mouth_open) {
    // Open mouth — red interior facing movement direction
    var mouth_x = x + lengthdir_x(head_r * 0.4, dir);
    var mouth_y = y + lengthdir_y(head_r * 0.4, dir);
    circle_3d(mouth_x, mouth_y, tip_gz, head_r * 0.7, make_color_rgb(180, 30, 30));

    // Teeth — two white triangles approximated as small circles
    var tooth_offset = head_r * 0.5;
    var t1x = x + lengthdir_x(tooth_offset, dir + 25);
    var t1y = y + lengthdir_y(tooth_offset, dir + 25);
    var t2x = x + lengthdir_x(tooth_offset, dir - 25);
    var t2y = y + lengthdir_y(tooth_offset, dir - 25);
    circle_3d(t1x, t1y, tip_gz + 1, 2, c_white);
    circle_3d(t2x, t2y, tip_gz + 1, 2, c_white);
} else {
    // Closed mouth — thin line
    var m1x = x + lengthdir_x(head_r * 0.6, dir + 15);
    var m1y = y + lengthdir_y(head_r * 0.6, dir + 15);
    var m2x = x + lengthdir_x(head_r * 0.6, dir - 15);
    var m2y = y + lengthdir_y(head_r * 0.6, dir - 15);
    line_3d(m1x, m1y, tip_gz, m2x, m2y, tip_gz, 1, make_color_rgb(80, 30, 30));
}

// Eyes — white with black pupils, positioned above mouth
var eye_offset = head_r * 0.35;
var le_x = x + lengthdir_x(eye_offset, dir + 40);
var le_y = y + lengthdir_y(eye_offset, dir + 40);
var re_x = x + lengthdir_x(eye_offset, dir - 40);
var re_y = y + lengthdir_y(eye_offset, dir - 40);
circle_3d(le_x, le_y, tip_gz + 5, 3, c_white);
circle_3d(re_x, re_y, tip_gz + 5, 3, c_white);

// Pupils — look toward movement direction
var pupil_dx = lengthdir_x(1, dir);
var pupil_dy = lengthdir_y(1, dir);
circle_3d(le_x + pupil_dx, le_y + pupil_dy, tip_gz + 6, 1.5, c_black);
circle_3d(re_x + pupil_dx, re_y + pupil_dy, tip_gz + 6, 1.5, c_black);
