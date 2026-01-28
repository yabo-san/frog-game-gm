function point_in_polygon(x0, y0, polygon)
{
    // Safety check
    if (!ds_exists(polygon, ds_type_list) || ds_list_size(polygon) < 6) return false;

    var inside = false;
    var n = ds_list_size(polygon) div 2;

    var polyX = [];
    var polyY = [];
    
    for (var i = 0; i < n; i++) {
        polyX[i] = ds_list_find_value(polygon, 2*i);
        polyY[i] = ds_list_find_value(polygon, 2*i+1);
    }

    // Close polygon
    polyX[n] = polyX[0];
    polyY[n] = polyY[0];

    var x1, y1, x2, y2;
    for (var i = 0; i < n; i++) {
        x1 = polyX[i];
        y1 = polyY[i];
        x2 = polyX[i+1];
        y2 = polyY[i+1];

        if ((y2 > y0) != (y1 > y0)) {
            inside ^= (x0 < (x1 - x2) * (y0 - y2) / (y1 - y2) + x2);
        }
    }

    return inside;
}
