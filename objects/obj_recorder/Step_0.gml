current_frame += 1;

// === RECORDING MODE ===
if (is_recording) {
    var left_click = mouse_check_button(mb_left);
    var right_click = mouse_check_button(mb_right);
    var z_key = keyboard_check(ord("Z"));
    
    var mx = obj_game.mouse_clamped_x;
    var my = obj_game.mouse_clamped_y;
    
    // Left click pressed
    if (left_click && !prev_left_click) {
        ds_list_add(recorded_events, {
            frame: current_frame,
            type: "left_press",
            x: mx,
            y: my
        });
    }
    
    // Right click / Z pressed (start drawing)
    if ((right_click && !prev_right_click) || (z_key && !prev_z_key)) {
        is_drawing = true;
        ds_list_add(recorded_events, {
            frame: current_frame,
            type: "draw_start",
            x: mx,
            y: my
        });
    }
    
    // Drawing points (only while drawing)
    if (is_drawing) {
        ds_list_add(recorded_events, {
            frame: current_frame,
            type: "draw_point",
            x: mx,
            y: my
        });
    }
    
    // Right click / Z released (stop drawing)
    if (is_drawing && (!right_click && prev_right_click) || (!z_key && prev_z_key)) {
        is_drawing = false;
        ds_list_add(recorded_events, {
            frame: current_frame,
            type: "draw_end",
            x: mx,
            y: my
        });
    }
    
    prev_left_click = left_click;
    prev_right_click = right_click;
    prev_z_key = z_key;
}

// === REPLAY MODE ===
if (is_replaying && replay_index < ds_list_size(recorded_events)) {
    var event = recorded_events[| replay_index];
    
    if (event.frame == current_frame) {
        // Inject this event into the game
        switch(event.type) {
            case "left_press":
                // TODO: Trigger tongue spawn
                break;
            case "draw_start":
                // TODO: Start brush drawing
                break;
            case "draw_point":
                // TODO: Add point to brush
                break;
            case "draw_end":
                // TODO: End brush drawing
                break;
        }
        
        replay_index += 1;
    }
}

// === CONTROLS ===
// Toggle recording
// === CONTROLS ===
// Save current recording buffer
if (keyboard_check_pressed(ord("P"))) {
    save_recording("recording.json");
    show_debug_message("Recording saved! " + string(ds_list_size(recorded_events)) + " events");
}

// Start replay
if (keyboard_check_pressed(ord("L"))) {
    if (load_recording("recording.json")) {
        random_set_seed(recording_seed);  // Restore seed!
        game_restart();
        
        is_replaying = true;
        is_recording = true;  // Keep recording
        replay_index = 0;
        current_frame = 0;
        show_debug_message("Replay started with seed " + string(recording_seed));
    }
}

if (keyboard_check_pressed(ord("I"))) {
    random_set_seed(obj_game.random_seed);  // Use current seed
    game_restart();
    
    is_replaying = true;
    replay_index = 0;
    current_frame = 0;
    show_debug_message("Instant replay started!");
}

// Stop replay
if (keyboard_check_pressed(ord("K")) && is_replaying) {
    is_replaying = false;
    show_debug_message("Replay stopped!");
}