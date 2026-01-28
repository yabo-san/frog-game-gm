/// @func scr_damage_enemy(enemy, damage)
/// @desc Apply damage to an enemy. If hp drops to 0 or below, mark as eatable. Does not destroy the enemy directly.
/// @param enemy   The enemy instance to damage
/// @param damage  Amount of damage to apply
/// @return true if enemy was newly marked as eatable, false otherwise

function scr_damage_enemy(enemy, damage) {
    // Apply damage
    enemy.hp -= damage;

    // If HP depleted, mark as eatable
    if (enemy.hp <= 0 && !enemy.eatable) {
        enemy.eatable = true;

        // Optional: swap sprite to eatable sprite
        if (variable_instance_exists(enemy, "sprite_eatable")) {
            enemy.sprite_index = enemy.sprite_eatable;
        }

        return true;  // newly eatable
    }

    return false; // still alive or already eatable
}
