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

/// @func enemy_cfg(enemy_type, key)
/// @desc Get per-enemy config with fallback to enemies.base
function enemy_cfg(enemy_type, key) {
    var enemy_val = global.config[$ "enemies"][$ enemy_type][$ key];
    if (!is_undefined(enemy_val)) return enemy_val;
    var base_val = global.config[$ "enemies"][$ "base"][$ key];
    if (!is_undefined(base_val)) return base_val;
    show_error("Enemy config key not found: " + enemy_type + "." + key + " (no base fallback)", true);
}