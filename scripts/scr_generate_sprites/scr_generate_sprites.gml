/// @func scr_generate_sprites()
/// @desc Generate collision mask sprites at runtime matching primitive draw sizes

function _make_circle_sprite(radius) {
    var sz = radius * 2 + 2;
    var cx = sz div 2;
    var cy = sz div 2;
    var surf = surface_create(sz, sz);
    surface_set_target(surf);
    draw_clear_alpha(c_black, 0);
    draw_set_color(c_white);
    draw_circle(cx, cy, radius, false);
    surface_reset_target();
    var spr = sprite_create_from_surface(surf, 0, 0, sz, sz, false, false, cx, cy);
    surface_free(surf);
    return spr;
}

function _make_ellipse_sprite(hw, hh) {
    var sw = hw * 2 + 2;
    var sh = hh * 2 + 2;
    var cx = sw div 2;
    var cy = sh div 2;
    var surf = surface_create(sw, sh);
    surface_set_target(surf);
    draw_clear_alpha(c_black, 0);
    draw_set_color(c_white);
    draw_ellipse(cx - hw, cy - hh, cx + hw, cy + hh, false);
    surface_reset_target();
    var spr = sprite_create_from_surface(surf, 0, 0, sw, sh, false, false, cx, cy);
    surface_free(surf);
    return spr;
}

function scr_generate_sprites() {
    // --- Core entities ---
    global.spr_player_mask = _make_circle_sprite(12);     // frog body radius
    global.spr_tongue_mask = _make_circle_sprite(5);       // tongue tip bulb
    global.spr_stinger_mask = _make_circle_sprite(6);      // stinger triangle ~area

    // --- Original enemies ---
    global.spr_fly_mask = _make_circle_sprite(8);          // fly body
    global.spr_bee_mask = _make_circle_sprite(10);         // bee body
    global.spr_snail_mask = _make_ellipse_sprite(12, 8);   // snail body+shell

    // --- New enemies ---
    global.spr_beetle = _make_circle_sprite(14);           // beetle radius from config
    global.spr_butterfly = _make_ellipse_sprite(28, 12);   // elongated oval
    global.spr_butterfly_eatable = _make_ellipse_sprite(28, 12);
    global.spr_spider = _make_circle_sprite(20);           // big spider body
    global.spr_heavy_bee_mask = _make_circle_sprite(22);   // heavy bee body
    global.spr_earthworm_mask = _make_circle_sprite(6);    // earthworm head
}
