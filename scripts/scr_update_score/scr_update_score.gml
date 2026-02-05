/// @func scr_update_score(points)
/// @desc Adds points, updates pickup chain and rank, refills ink
function scr_update_score(points) {
    global.game_score += points;
    global.pickup_chain += 1;
    
    if (global.pickup_chain % 3 == 0) {
        global.rank += 1;
    }
    
    // Refill ink per enemy kill
    if (instance_exists(obj_brush)) {
        var ink_per_kill = cfg("ink.refill_per_kill");
        var combo_bonus = floor(global.current_chain / cfg("scoring.combo_ink_threshold")) * cfg("scoring.combo_ink_bonus");
        obj_brush.refill_ink(ink_per_kill + combo_bonus);
    }
}