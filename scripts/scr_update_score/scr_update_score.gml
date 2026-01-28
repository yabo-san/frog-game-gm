/// @func scr_update_score(points)
/// @desc Adds points, updates pickup chain and rank
function scr_update_score(points) {
    global.game_score += points;
    global.pickup_chain += 1;
    if (global.pickup_chain % 3 == 0) {
        global.rank += 1;
    }
}
