/// @func scr_damage_player(lives_cost, [source])
/// @desc Deducts lives from the player, handles invulnerability and game over
/// @param lives_cost  Number of lives to lose
/// @param source      (Optional) What damaged the player
function scr_damage_player(lives_cost, source = noone) {
    if (!instance_exists(obj_player)) return false;
    if (obj_player.invuln_timer > 0) return false;

    global.lives -= lives_cost;

    if (global.lives <= 0) {
        global.lives = 0;
        instance_destroy(obj_player);
        room_restart();
        return true;
    }

    // Respawn: grant invulnerability, reset chain
    obj_player.invuln_timer = obj_player.invuln_duration;
    global.current_chain = 0;
    return true;
}
