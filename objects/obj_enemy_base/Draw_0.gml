draw_self();
// Debug: show slow level and timers
if (slow_level > 0 || vulnerability_timer > 0) {
    draw_set_color(c_red);
    draw_text(x, y - 30, "Level: " + string(slow_level));
    draw_text(x, y - 45, "Mult: " + string(speed_mult));
    draw_text(x, y - 60, "SlowTimer: " + string(slow_timer));
    draw_text(x, y - 75, "VulnTimer: " + string(vulnerability_timer));
}