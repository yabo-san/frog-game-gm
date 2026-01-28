/// @func scr_damage_player(amount, [source])
/// @desc Damages the player and handles death
/// @param amount  Amount of damage to deal
/// @param source  (Optional) What damaged the player
function scr_damage_player(amount, source = noone) {
    if (!instance_exists(obj_player)) return false;
    
    // Apply damage
    obj_player.hp -= amount;
    
    // Visual/audio feedback (optional)
    // screen_shake(5, 10);
    // audio_play_sound(snd_player_hurt, 1, false);
    
    // Check for death
    if (obj_player.hp <= 0) {
        obj_player.hp = 0;
        instance_destroy(obj_player);
        
        // Game over logic
        room_restart();  // ← Uncomment this to restart on death
        // room_goto(rm_game_over);
        
        return true;  // Player died
    }
    
    return false;  // Player survived
}