/// @func scr_path_has_intersection(points_list)
/// @desc Check if path crosses itself and return intersection details
/// @return Array [has_intersection (bool), segment_i, segment_j, intersection_x, intersection_y]
function scr_path_has_intersection(points_list) {
    var num_segments = (ds_list_size(points_list) / 2) - 1;
    if (num_segments < 4) return [false, -1, -1, 0, 0];
    
    for (var i = 0; i < num_segments - 1; i++) {
        var x1 = points_list[| i * 2];
        var y1 = points_list[| i * 2 + 1];
        var x2 = points_list[| (i + 1) * 2];
        var y2 = points_list[| (i + 1) * 2 + 1];
        
        for (var j = i + 3; j < num_segments; j++) {
            var x3 = points_list[| j * 2];
            var y3 = points_list[| j * 2 + 1];
            var x4 = points_list[| (j + 1) * 2];
            var y4 = points_list[| (j + 1) * 2 + 1];
            
            var result = scr_segments_intersect(x1, y1, x2, y2, x3, y3, x4, y4);
            if (result[0]) {  // Intersection found!
                return [true, i, j, result[1], result[2]];
            }
        }
    }
    
    return [false, -1, -1, 0, 0];
}