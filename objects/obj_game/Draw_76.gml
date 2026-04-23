// --- Post Draw: black background + game surface centered + panel UI ---
var _dw = window_get_width();
var _dh = window_get_height();
var _scale = _dh / 480;
var _pw = floor(640 * _scale);
var _px = floor((_dw - _pw) / 2);

// Black background + centered game surface
draw_set_colour(c_black);
draw_rectangle(0, 0, _dw, _dh, false);
draw_set_colour(c_white);
gpu_set_tex_filter(false);
draw_surface_ext(application_surface, _px, 0, _scale, _scale, 0, c_white, 1);

// --- Left panel UI (same coordinate space as surface) ---
gpu_set_tex_filter(false);
var lp_w = _px;
var ts = _scale;

if (lp_w < 20) exit;

var margin = floor(10 * ts);
var tx = margin;
var ty = floor(20 * ts);
var line_h = floor(14 * ts);
var section_gap = floor(24 * ts);

// Score
draw_set_color(c_lime);
draw_text_transformed(tx, ty, "SCORE", ts, ts, 0);
ty += line_h;
draw_text_transformed(tx, ty, string(global.game_score), ts, ts, 0);
ty += section_gap;

// Rank
draw_set_color(c_yellow);
draw_text_transformed(tx, ty, "RANK", ts, ts, 0);
ty += line_h;
draw_text_transformed(tx, ty, string(global.rank), ts, ts, 0);
ty += section_gap;

// Lives
draw_set_color(c_red);
draw_text_transformed(tx, ty, "LIVES", ts, ts, 0);
ty += line_h;
draw_text_transformed(tx, ty, string(global.lives), ts, ts, 0);
ty += section_gap;

// Chain
draw_set_color(c_orange);
draw_text_transformed(tx, ty, "CHAIN", ts, ts, 0);
ty += line_h;
draw_text_transformed(tx, ty, string(global.current_chain), ts, ts, 0);
ty += section_gap;

// Ink bar
if (instance_exists(brush)) {
    draw_set_color(c_aqua);
    draw_text_transformed(tx, ty, "INK", ts, ts, 0);
    ty += line_h;

    var bar_w = lp_w - margin * 2;
    var bar_h = floor(8 * ts);

    draw_set_color(c_dkgray);
    draw_rectangle(tx, ty, tx + bar_w, ty + bar_h, false);

    var fill_w = (brush.ink_current / brush.ink_max) * bar_w;
    draw_set_color(c_aqua);
    draw_rectangle(tx, ty, tx + fill_w, ty + bar_h, false);

    draw_set_color(c_white);
    draw_rectangle(tx, ty, tx + bar_w, ty + bar_h, true);

    ty += bar_h + floor(4 * ts);
    draw_text_transformed(tx, ty, string(floor(brush.ink_current)) + "/" + string(brush.ink_max), ts, ts, 0);
}

draw_set_color(c_white);
