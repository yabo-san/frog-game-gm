// Brush state
brush_drawing = false;
brush_points = ds_list_create();
brush_circles_completed = 0;

// Active walls
active_walls = ds_list_create();

// Reference to player (set by obj_game)
player = noone;

// Ink resource
ink_current = 100;
ink_max = 100;
ink_drain_rate = 0.5;  // Ink per frame while drawing



/// Refill ink (called when enemies killed)
refill_ink = function(amount) {
    ink_current = min(ink_current + amount, ink_max);
    show_debug_message("Ink refilled: +" + string(amount));
}

ink_current = cfg("ink.max");
ink_max = cfg("ink.max");
ink_drain_rate = cfg("ink.drain_rate");