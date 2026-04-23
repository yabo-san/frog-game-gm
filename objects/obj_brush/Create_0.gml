// Brush state
brush_drawing = false;
brush_points = ds_list_create();
brush_circles_completed = 0;

// Active walls
active_walls = ds_list_create();

// Reference to player (set by obj_game)
player = noone;


/// Refill ink (called when enemies killed)
refill_ink = function(amount) {
    ink_current = min(ink_current + amount, ink_max);
    show_debug_message("Ink refilled: +" + string(amount));
}

ink_current = cfg("ink.max");
ink_max = cfg("ink.max");
ink_drain_rate = cfg("ink.drain_rate");

// Simulated input state (for replay)
replay_left_held = false;
replay_right_held = false;
replay_z_held = false;

/// Check if left mouse is pressed (real or replayed)


/// Check if right/Z is held (real or replayed)
is_draw_held = function() {
    if (instance_exists(obj_recorder) && obj_recorder.is_replaying) {
        return replay_right_held;
    }
    return mouse_check_button(mb_right) || keyboard_check(ord("Z"));
}

/// Check if drawing just started
is_draw_pressed = function() {
    if (instance_exists(obj_recorder) && obj_recorder.is_replaying) {
        return replay_right_held && !replay_right_prev;
    }
    return mouse_check_button_pressed(mb_right) || keyboard_check_pressed(ord("Z"));
}

/// Check if drawing just stopped
is_draw_released = function() {
    if (instance_exists(obj_recorder) && obj_recorder.is_replaying) {
        return !replay_right_held && replay_right_prev;
    }
    return mouse_check_button_released(mb_right) || keyboard_check_released(ord("Z"));
}

