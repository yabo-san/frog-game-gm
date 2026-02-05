draw_set_color(c_white);
draw_text(10, 10, "Score: " + string(global.game_score));
draw_text(10, 30, "Rank: " + string(global.rank));
draw_text(10, 50, "Combo: " + string(global.current_chain));

// Draw ink bar
if (instance_exists(brush)) {
    var bar_x = 10;
    var bar_y = 70;
    var bar_width = 100;
    var bar_height = 10;
    
    // Background
    draw_set_color(c_dkgray);
    draw_rectangle(bar_x, bar_y, bar_x + bar_width, bar_y + bar_height, false);
    
    // Ink fill
    var fill_width = (brush.ink_current / brush.ink_max) * bar_width;
    draw_set_color(c_aqua);
    draw_rectangle(bar_x, bar_y, bar_x + fill_width, bar_y + bar_height, false);
    
    // Border
    draw_set_color(c_white);
    draw_rectangle(bar_x, bar_y, bar_x + bar_width, bar_y + bar_height, true);
    
    draw_text(bar_x + bar_width + 5, bar_y, string(floor(brush.ink_current)) + "/" + string(brush.ink_max));
}