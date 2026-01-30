/// @func scr_extract_loop(points_list, segment_i, segment_j, ix, iy)
/// @desc Extract the loop portion of a path between two intersecting segments
/// @return ds_list containing the loop points
function scr_extract_loop(points_list, segment_i, segment_j, ix, iy) {
    var loop = ds_list_create();
    
    // Add intersection point as start
    ds_list_add(loop, ix, iy);
    
    // Add all points between segment_i and segment_j
    for (var k = segment_i + 1; k <= segment_j; k++) {
        var px = points_list[| k * 2];
        var py = points_list[| k * 2 + 1];
        ds_list_add(loop, px, py);
    }
    
    // Close loop with intersection point
    ds_list_add(loop, ix, iy);
    
    return loop;
}