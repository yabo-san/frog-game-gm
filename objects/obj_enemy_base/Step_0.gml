// Update effects
if (effect == "slow") speed_mult = 0.5;
else if (effect == "freeze") speed_mult = 0;

if (effect_timer > 0) effect_timer--;
else { effect = ""; speed_mult = 1; }



// Sprite swap for eatable state
//if (eatable) sprite_index = sprite_eatable;
//else sprite_index = sprite_normal;
scr_update_eatable(id)