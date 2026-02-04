/// @func point_distance_to_line(px, py, x1, y1, x2, y2)
function point_distance_to_line(px, py, x1, y1, x2, y2) {
    var dx = x2 - x1;
    var dy = y2 - y1;
    var len_sq = dx * dx + dy * dy;
    
    if (len_sq == 0) return point_distance(px, py, x1, y1);
    
    var t = clamp(((px - x1) * dx + (py - y1) * dy) / len_sq, 0, 1);
    var proj_x = x1 + t * dx;
    var proj_y = y1 + t * dy;
    
    return point_distance(px, py, proj_x, proj_y);
}