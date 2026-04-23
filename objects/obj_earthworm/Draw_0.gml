/// Earthworm — stationary high-value target
var seg_count = 5;
var seg_r = 4;
var seg_gap = 7;
var gz = seg_r + 1;

// Spawn indicator phase — pulsing green circle on the ground
if (spawn_delay > 0) {
    var pulse = 0.5 + 0.5 * sin(spawn_delay * 0.2);
    var indicator_r = 12 + pulse * 6;
    draw_set_alpha(0.4 + pulse * 0.3);
    circle_3d(x, y, 0, indicator_r, make_color_rgb(230, 130, 150));
    draw_set_alpha(1);
    exit;
}

// Flash when about to despawn
if (lifetime < 90 && (floor(lifetime / 6) mod 2 == 0)) exit;

// Draw worm segments in a coil (stationary)
for (var i = seg_count - 1; i >= 0; i--) {
    var angle = i * 50;
    var dist = i * 4;
    var sx = x + lengthdir_x(dist, angle);
    var sy = y + lengthdir_y(dist, angle);

    circle_3d(sx, sy, 0, seg_r - 1, c_gray);
    var pink = make_color_rgb(230, 130, 150);
    var pink_head = make_color_rgb(240, 160, 170);
    circle_3d(sx, sy, gz, seg_r, (i == 0) ? pink_head : pink);
}

// Eyes
circle_3d(x, y, gz + 3, 1, c_black);

// Timer bar
var bar_x = x - 10;
var bar_y = y - 16;
var bar_w = 20 * (lifetime / enemy_cfg("earthworm", "lifetime"));
draw_set_color(make_color_rgb(230, 130, 150));
draw_rectangle(bar_x, bar_y, bar_x + bar_w, bar_y + 3, false);
draw_set_color(c_white);
draw_rectangle(bar_x, bar_y, bar_x + 20, bar_y + 3, true);
