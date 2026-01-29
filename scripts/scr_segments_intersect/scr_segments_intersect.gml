/// @func scr_segments_intersect(x1, y1, x2, y2, x3, y3, x4, y4)
/// @desc Check if two line segments intersect
function scr_segments_intersect(x1, y1, x2, y2, x3, y3, x4, y4) {
    // Calculate cross products to determine orientation
    var d1 = (x2 - x1) * (y3 - y1) - (y2 - y1) * (x3 - x1);
    var d2 = (x2 - x1) * (y4 - y1) - (y2 - y1) * (x4 - x1);
    var d3 = (x4 - x3) * (y1 - y3) - (y4 - y3) * (x1 - x3);
    var d4 = (x4 - x3) * (y2 - y3) - (y4 - y3) * (x2 - x3);
    
    // Segments intersect if points are on opposite sides
    if (((d1 > 0 && d2 < 0) || (d1 < 0 && d2 > 0)) &&
        ((d3 > 0 && d4 < 0) || (d3 < 0 && d4 > 0))) {
        return true;
    }
    
    return false;
}