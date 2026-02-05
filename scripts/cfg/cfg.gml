/// @func cfg(path)
/// @desc Get config value by dot notation path
function cfg(path) {
    var keys = string_split(path, ".");
    var current = global.config;
    
    for (var i = 0; i < array_length(keys); i++) {
        current = current[$ keys[i]];
        if (is_undefined(current)) {
            show_error("Config key not found: " + path, true);
        }
    }
    
    return current;
}