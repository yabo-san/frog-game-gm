// Count how many slow zones this enemy is inside
slow_stacks = 0;
with (obj_slow_zone) {
    if (point_in_polygon(other.x, other.y, polygon_points)) {
        other.slow_stacks += 1;
    }
}

// Apply speed multiplier based on stacks
if (slow_stacks == 0) speed_mult = 1.0;
else if (slow_stacks == 1) speed_mult = 0.75;
else if (slow_stacks == 2) speed_mult = 0.5;
else speed_mult = 0;


// Update effects
if (effect == "slow") speed_mult = 0.5;
else if (effect == "freeze") speed_mult = 0;

if (effect_timer > 0) effect_timer--;
else { effect = ""; speed_mult = 1; }



// Sprite swap for eatable state
//if (eatable) sprite_index = sprite_eatable;
//else sprite_index = sprite_normal;
scr_update_eatable(id)