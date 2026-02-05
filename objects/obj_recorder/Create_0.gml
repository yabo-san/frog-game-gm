// Recording state
is_recording = true;  // Always recording
is_replaying = false;
current_frame = 0;

// Ring buffer - only keep last N frames worth of events
max_events = 10000;  // Roughly 2-3 minutes at 60fps
recorded_events = ds_list_create();
replay_index = 0;

// Button state tracking
prev_left_click = false;
prev_right_click = false;
prev_z_key = false;
is_drawing = false;

// Store the RNG seed used for this recording
recording_seed = 0;

/// Save recording to file
save_recording = function(filename) {
    var recording_data = {
        seed: obj_game.random_seed,
        events: []
    };
    
    for (var i = 0; i < ds_list_size(recorded_events); i++) {
        array_push(recording_data.events, recorded_events[| i]);
    }
    
    var json_string = json_stringify(recording_data);
    var file = file_text_open_write(filename);
    file_text_write_string(file, json_string);
    file_text_close(file);
}

/// Load recording from file
load_recording = function(filename) {
    if (!file_exists(filename)) {
        show_debug_message("Recording file not found: " + filename);
        return false;
    }
    
    var file = file_text_open_read(filename);
    var json_string = file_text_read_string(file);
    file_text_close(file);
    
    var recording_data = json_parse(json_string);
    recording_seed = recording_data.seed;
    
    ds_list_clear(recorded_events);
    for (var i = 0; i < array_length(recording_data.events); i++) {
        ds_list_add(recorded_events, recording_data.events[i]);
    }
    
    return true;
}