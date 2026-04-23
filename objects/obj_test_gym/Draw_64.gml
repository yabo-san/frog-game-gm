/// Test Gym — debug HUD (right panel)
var dw = window_get_width();
var dh = window_get_height();
display_set_gui_size(dw, dh);

var scale = dh / 480;
var pw = floor(640 * scale);
var rp_x = floor((dw + pw) / 2) + floor(10 * scale);
var ts = scale;
var ty = floor(20 * ts);
var line_h = floor(12 * ts);

draw_set_halign(fa_left);
gpu_set_tex_filter(false);

// Title
draw_set_color(c_white);
draw_text_transformed(rp_x, ty, "TEST GYM", ts, ts, 0);
ty += line_h * 2;

// Mode
draw_set_color(c_yellow);
draw_text_transformed(rp_x, ty, "[G] Mode: " + string_upper(mode), ts * 0.8, ts * 0.8, 0);
ty += line_h;

// Freeze
draw_set_color(enemies_frozen ? c_red : c_lime);
draw_text_transformed(rp_x, ty, "[M] Move: " + (enemies_frozen ? "FROZEN" : "ON"), ts * 0.8, ts * 0.8, 0);
ty += line_h;

// Teleport
draw_set_color(c_aqua);
draw_text_transformed(rp_x, ty, "[T] Teleport", ts * 0.8, ts * 0.8, 0);
ty += line_h * 1.5;

if (mode == "gauntlet") {
    var wave_count = array_length(gauntlet_waves);

    draw_set_color(c_white);
    draw_text_transformed(rp_x, ty, "GAUNTLET", ts * 0.8, ts * 0.8, 0);
    ty += line_h;

    for (var i = 0; i < wave_count; i++) {
        if (i < gauntlet_index) {
            draw_set_color(c_dkgray);
        } else if (i == gauntlet_index) {
            draw_set_color(c_lime);
        } else {
            draw_set_color(c_gray);
        }
        var prefix = (i == gauntlet_index) ? "> " : "  ";
        draw_text_transformed(rp_x, ty, prefix + gauntlet_waves[i].name, ts * 0.7, ts * 0.7, 0);
        ty += line_h * 0.9;
    }
} else {
    var count = array_length(enemy_types);
    draw_set_color(c_white);
    draw_text_transformed(rp_x, ty, "GRID [1-0]", ts * 0.8, ts * 0.8, 0);
    ty += line_h;

    for (var i = 0; i < count; i++) {
        var key_label = (i < 9) ? string(i + 1) : "0";
        draw_set_color(enemy_enabled[i] ? c_lime : c_dkgray);
        draw_text_transformed(rp_x, ty, "[" + key_label + "] " + enemy_names[i], ts * 0.7, ts * 0.7, 0);
        ty += line_h;
    }
}

draw_set_color(c_white);
draw_set_halign(fa_left);
