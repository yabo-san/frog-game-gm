/// Butterfly — 3D: purple body, wings fall off with each hit
var gz = 20;
var wing_col = eatable ? c_yellow : c_fuchsia;
var body_col = eatable ? c_lime : c_purple;
var max_hp = enemy_cfg("butterfly", "hp");

// Shadow
circle_3d(x, y, 0, 8, c_gray);

// Wings — one falls off per hit
// hp == max_hp: both wings, hp == max_hp-1: right wing only, hp <= 0: no wings (eatable)
if (hp >= max_hp) {
    // Both wings
    circle_3d(x - 16, y, gz + 4, 10, wing_col);
    circle_3d(x + 16, y, gz + 4, 10, wing_col);
} else if (hp >= max_hp - 1 && !eatable) {
    // One wing left
    circle_3d(x + 16, y, gz + 4, 10, wing_col);
}
// No wings when eatable

// Body
circle_3d(x, y, gz, 6, body_col);

// Eyes
circle_3d(x - 2, y, gz + 5, 2, c_black);
circle_3d(x + 2, y, gz + 5, 2, c_black);
