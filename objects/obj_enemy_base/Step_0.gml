// Decrease slow timer
if (slow_timer > 0) {
    slow_timer -= 1;
    
    // When timer expires, reduce stacks
    if (slow_timer <= 0 && slow_stacks > 0) {
        slow_stacks -= 1;
        if (slow_stacks > 0) {
            slow_timer = slow_duration;  // Reset timer for next stack
        }
    }
}

// Apply speed multiplier based on current stacks
if (slow_stacks == 0) speed_mult = 1.0;
else if (slow_stacks == 1) speed_mult = 0.75;
else if (slow_stacks == 2) speed_mult = 0.5;
else speed_mult = 0;  // 3+ stacks = frozen

// Sprite swap for eatable state
scr_update_eatable(id);