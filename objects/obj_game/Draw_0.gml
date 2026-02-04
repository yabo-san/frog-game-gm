// Draw custom crosshair
draw_set_color(c_yellow);
draw_line(mouse_clamped_x - 5, mouse_clamped_y, mouse_clamped_x + 5, mouse_clamped_y);
draw_line(mouse_clamped_x, mouse_clamped_y - 5, mouse_clamped_x, mouse_clamped_y + 5);
draw_set_color(c_white);