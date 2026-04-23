// --- Ground plane pebbles (at z=0) ---
for (var i = 0; i < pebble_count; i++) {
    circle_3d(pebble_x[i], pebble_y[i], 0, pebble_r[i], make_color_rgb(170, 140, 100));
}

// --- Foliage border (elevated slightly, z=5) ---
var dark_green = make_color_rgb(30, 80, 30);
var mid_green = make_color_rgb(50, 120, 50);

// Border bumps
for (var i = 0; i < array_length(foliage_bumps); i++) {
    circle_3d(foliage_bumps[i].fx, foliage_bumps[i].fy, 5, foliage_bumps[i].fr, mid_green);
}

// Corner clusters (slightly higher)
for (var i = 0; i < array_length(foliage_corners); i++) {
    circle_3d(foliage_corners[i].fx, foliage_corners[i].fy, 8, foliage_corners[i].fr, dark_green);
}

// --- Crosshair (drawn at screen-space mouse position on the 640x480 surface) ---
var cx = mouse_screen_x;
var cy = mouse_screen_y;
draw_set_color(c_purple);
draw_circle(cx, cy, 8, true);
draw_line(cx - 5, cy, cx + 5, cy);
draw_line(cx, cy - 5, cx, cy + 5);
draw_circle(cx, cy, 1, false);
draw_set_color(c_white);
