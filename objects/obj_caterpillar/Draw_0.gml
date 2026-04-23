/// Caterpillar — 3D: chain of spheres with legs
var seg_positions = array_create(num_segments);
seg_positions[0] = { hx: x, hy: y };
for (var i = 1; i < num_segments; i++) {
    var hist_idx = (history_index - i * seg_spacing + history_len * 10) mod history_len;
    seg_positions[i] = pos_history[hist_idx];
}

var segs_per_zone = num_segments div 3;
var gz = seg_radius + 2;

// Build draw order sorted by Y (higher Y = further from camera = draw first)
var draw_order = array_create(num_segments);
for (var i = 0; i < num_segments; i++) draw_order[i] = i;

// Simple insertion sort by Y descending (further first)
for (var i = 1; i < num_segments; i++) {
    var key = draw_order[i];
    var key_y = seg_positions[key].hy;
    var j = i - 1;
    while (j >= 0 && seg_positions[draw_order[j]].hy < key_y) {
        draw_order[j + 1] = draw_order[j];
        j--;
    }
    draw_order[j + 1] = key;
}

// Draw in sorted order
for (var di = 0; di < num_segments; di++) {
    var i = draw_order[di];
    var sx = seg_positions[i].hx;
    var sy = seg_positions[i].hy;
    var zone = clamp(i div segs_per_zone, 0, 2);

    var col;
    if (eatable) {
        col = c_lime;
    } else if (zone_painted[zone]) {
        col = c_purple;
    } else {
        col = (i == 0) ? c_yellow : c_orange;
    }

    // Shadow
    circle_3d(sx, sy, 0, seg_radius - 1, c_gray);

    // Legs (draw before body so body overlaps them)
    if (i > 0) {
        var prev = seg_positions[i - 1];
        var seg_angle = point_direction(sx, sy, prev.hx, prev.hy);
        var ll_x = sx + lengthdir_x(seg_radius + 3, seg_angle + 90);
        var ll_y = sy + lengthdir_y(seg_radius + 3, seg_angle + 90);
        var lr_x = sx + lengthdir_x(seg_radius + 3, seg_angle - 90);
        var lr_y = sy + lengthdir_y(seg_radius + 3, seg_angle - 90);
        line_3d(sx, sy, gz, ll_x, ll_y, 0, 2, c_black);
        line_3d(sx, sy, gz, lr_x, lr_y, 0, 2, c_black);
    }

    // Segment sphere
    circle_3d(sx, sy, gz, seg_radius, col);
}

// Head eyes (always on top)
var hx = seg_positions[0].hx;
var hy = seg_positions[0].hy;
circle_3d(hx - 3, hy, gz + 5, 2, c_black);
circle_3d(hx + 3, hy, gz + 5, 2, c_black);
