/// @func scr_segments_intersect(x1, y1, x2, y2, x3, y3, x4, y4)
/// @desc Check if two line segments intersect and return intersection point
/// @return Array [intersects (bool), intersection_x, intersection_y]
function scr_segments_intersect(x1, y1, x2, y2, x3, y3, x4, y4) {
    var denom = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
    
    // Lines are parallel
    if (abs(denom) < 0.0001) {
        return [false, 0, 0];
    }
    
    var t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / denom;
    var u = -((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) / denom;
    
    // Check if intersection is within both segments
    if (t >= 0 && t <= 1 && u >= 0 && u <= 1) {
        var ix = x1 + t * (x2 - x1);
        var iy = y1 + t * (y2 - y1);
        return [true, ix, iy];
    }
    
    return [false, 0, 0];
}