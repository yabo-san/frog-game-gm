// Debug: draw object name above every enemy
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_text(x, y - 24, object_get_name(object_index));
draw_set_halign(fa_left);
