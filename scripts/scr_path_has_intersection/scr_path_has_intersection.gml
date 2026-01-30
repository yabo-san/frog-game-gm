/// @func scr_path_has_intersection(points_list)
/// @desc Check if a path crosses itself
function scr_path_has_intersection(points_list) {
    var num_segments = (ds_list_size(points_list) / 2) - 1;
    if (num_segments < 4) return false;  // Need at least 4 segments
    
    // Check each segment against every non-adjacent segment
    for (var i = 0; i < num_segments - 1; i++) {
        var x1 = points_list[| i * 2];
        var y1 = points_list[| i * 2 + 1];
        var x2 = points_list[| (i + 1) * 2];
        var y2 = points_list[| (i + 1) * 2 + 1];
        
        // Start from i+3 to skip adjacent segments (i+1 shares endpoint, i+2 is next to it)
        for (var j = i + 3; j < num_segments; j++) {  // ← Changed from i+2 to i+3
            var x3 = points_list[| j * 2];
            var y3 = points_list[| j * 2 + 1];
            var x4 = points_list[| (j + 1) * 2];
            var y4 = points_list[| (j + 1) * 2 + 1];
            
            if (scr_segments_intersect(x1, y1, x2, y2, x3, y3, x4, y4)) {
                return true;
            }
        }
    }
    
    return false;
}