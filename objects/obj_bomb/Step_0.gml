if (keyboard_check(vk_space) || (mouse_check_button(mb_left) && mouse_check_button(mb_right))) {
    is_charging = true;
    if (radius < max_radius) radius += charge_rate;
} else {
    if (is_charging) {
        with (obj_enemy_base) {
            if (point_distance(other.x, other.y, x, y) <= radius) {
                scr_damage_enemy(id, 999);
            }
        }
    }
    is_charging = false;
    radius = 0;
}
