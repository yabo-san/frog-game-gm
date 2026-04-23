// === SLOW TAGGING SYSTEM ===
// Count down active slow
if (slow_timer > 0) {
    slow_timer -= 1;
    
    if (slow_timer <= 0) {
        // Slow wore off, start vulnerability window
        vulnerability_timer = vulnerability_duration;
    }
}

// Count down vulnerability window
if (vulnerability_timer > 0 && slow_timer <= 0) {
    vulnerability_timer -= 1;
    
    if (vulnerability_timer <= 0) {
        // Window closed, reset to level 0
        slow_level = 0;
    }
}

// Apply speed based on slow level
if (slow_level == 0) speed_mult = 1.0;
else if (slow_level == 1) speed_mult = 0.75;
else if (slow_level == 2) speed_mult = 0.5;
else speed_mult = 0;  // Level 3+ = frozen

// Sprite swap for eatable state
scr_update_eatable(id);

// Depth sorting for fake 3D (fixed camera = Y-sort works)
if (global.view_mode != "2d") {
    depth = -y;
} else {
    depth = 0;
}