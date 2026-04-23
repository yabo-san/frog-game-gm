// If spider is gone, destroy self
if (!instance_exists(spider)) {
    instance_destroy();
    exit;
}

// Follow spider
x = spider.x;
y = spider.y;

// Web line endpoints
var wx1, wy1, wx2, wy2;
if (axis == "vertical") {
    wx1 = x; wy1 = 0;
    wx2 = x; wy2 = room_height;
} else {
    wx1 = 0; wy1 = y;
    wx2 = room_width; wy2 = y;
}

// --- Tongue collision ---
if (instance_exists(obj_tongue)) {
    var t = obj_tongue;
    if (t.moving && !t.retracting) {
        // Check if tongue tip is near the web line
        var dist_to_web = point_distance_to_line(t.x, t.y, wx1, wy1, wx2, wy2);
        if (dist_to_web < 8) {
            // Check if tongue is aimed at the spider (frog would intercept)
            // Use the line from frog to tongue target — is spider close to that path?
            var aimed_at_spider = false;
            if (instance_exists(t.frog) && instance_exists(spider)) {
                var dist_spider_to_path = point_distance_to_line(
                    spider.x, spider.y,
                    t.frog.x, t.frog.y,
                    t.target_x, t.target_y
                );
                // Also check spider is on the far side of web from frog
                var spider_past_web = false;
                if (axis == "vertical") {
                    spider_past_web = (sign(spider.x - x) == sign(t.target_x - t.frog.x))
                                   || abs(spider.x - x) < 16;
                } else {
                    spider_past_web = (sign(spider.y - y) == sign(t.target_y - t.frog.y))
                                   || abs(spider.y - y) < 16;
                }
                if (dist_spider_to_path < 24 && spider_past_web) {
                    aimed_at_spider = true;
                }
            }

            if (!aimed_at_spider) {
                t.retracting = true;
            }
            // If aimed at spider, tongue passes through — frog will eat spider on arrival
        }
    }
}

// --- Player collision (lethal) ---
if (instance_exists(obj_player)) {
    var p = obj_player;
    var dist_to_web = point_distance_to_line(p.x, p.y, wx1, wy1, wx2, wy2);
    if (dist_to_web < 6) {
        scr_damage_player(999, id);
    }
}
