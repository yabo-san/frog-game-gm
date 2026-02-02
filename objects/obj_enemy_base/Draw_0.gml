draw_self();
//if (slow_stacks > 0) {
    //draw_set_color(c_yellow);
    //draw_set_halign(fa_center);
    //draw_text(x, y - 20, "x" + string(slow_stacks));
    //draw_set_halign(fa_left);
//}

// Debug: show slow stacks
if (slow_stacks > 0) {
    draw_set_color(c_red);
    draw_text(x, y - 30, "Stacks: " + string(slow_stacks));
    draw_text(x, y - 45, "Mult: " + string(speed_mult));
}