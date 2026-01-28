/// @func scr_update_eatable(enemy)
/// @desc Updates the sprite of an enemy based on whether it is eatable
/// @param enemy  Instance reference of the enemy

function scr_update_eatable(enemy) {
    if (!instance_exists(enemy)) return;

    if (enemy.eatable) {
        if (variable_instance_exists(enemy, "sprite_eatable"))
            enemy.sprite_index = enemy.sprite_eatable;
    } else {
        if (variable_instance_exists(enemy, "sprite_normal"))
            enemy.sprite_index = enemy.sprite_normal;
    }
}
