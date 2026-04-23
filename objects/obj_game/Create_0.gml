// Generate placeholder sprites before anything else
scr_generate_sprites();

// Load config FIRST
var buffer = buffer_load("game_config.json");
var json_string = buffer_read(buffer, buffer_text);
buffer_delete(buffer);
global.config = json_parse(json_string);

var target_fps = 60;
var speed_mult = cfg("debug.game_speed_multiplier");
game_set_speed(target_fps * speed_mult, gamespeed_fps);

// --- Gameplay globals ---
global.game_score = 0;


global.rank = 1;
global.lives = cfg("player.lives");
global.pickup_chain = 0;
global.current_chain = 0;

player = noone;
brush = noone;

enemy_spawn_timer = 0;
enemy_spawn_rate = cfg("enemies.spawn_rate");  // was 120

// Spider tracking — max 2, alternating axis
last_spider_axis = "horizontal";  // next one will be vertical

random_seed = 12345;
random_set_seed(random_seed);

// --- Setup display ---
var cam = camera_create_view(0, 0, 640, 480);
camera_set_view_size(cam, 640, 480);
camera_set_view_pos(cam, 0, 0);
view_camera[0] = cam;

surface_resize(application_surface, 640, 480);
application_surface_draw_enable(false);
gpu_set_tex_filter(false);
window_set_cursor(cr_none);

// Size window to fill vertical space with side panels for UI
is_fullscreen = false;
var _dw = display_get_width();
var _dh = display_get_height();
// Reserve ~8% for system chrome (menu bar, taskbar, title bar, dock)
var _avail_h = floor(_dh * 0.92);
var _scale = _avail_h / 480;
var _win_h = floor(480 * _scale);
var _win_w = floor(_dw * 0.96);
window_set_size(_win_w, _win_h);
window_center();

// Play area layout (recalculated each step)
play_area_x = 0;
play_area_y = 0;
play_area_w = 640;
play_area_h = 480;
play_area_scale = 1;
panel_width = 0;

// Virtual mouse starts at center
mouse_game_x = 320;
mouse_game_y = 240;
mouse_screen_x = 320;
mouse_screen_y = 240;

// --- View mode: "2d" or "3d", toggle with V ---
global.view_mode = "2d";

// --- Fake 3D globals ---
globalvar res_screen_x, res_screen_y, res_screen_z, res_screen_scale, res_world_x, res_world_y;
res_screen_x = 0;
res_screen_y = 0;
res_screen_z = 0;
res_screen_scale = 1;
res_world_x = 0;
res_world_y = 0;

// --- Fake 3D camera (sokpop style) ---
// Depth forcing set on V toggle, not here (layer may not exist yet)

global.cam = {
    cam_x: 0,
    cam_y: 0,
    cam_z: 300,
    cam_rotation: 0,
    cam_pitch: -25,
    cam_width: 640,
    cam_height: 480,
    cam_zoom: 0.5,
    cam_fov: 0.35,
    cam_near: 0,
    cam_far: 400,
    farnear_comp: 1 / 400,
    m00: 0, m10: 0, m01: 0, m11: 0,
    cam_yscale: 1, cam_zscale: 0
};

// Pre-compute camera matrices
var _c = global.cam;
_c.m00 = lengthdir_x(1, _c.cam_rotation);
_c.m10 = lengthdir_y(-1, _c.cam_rotation);
_c.m01 = lengthdir_y(1, _c.cam_rotation);
_c.m11 = lengthdir_x(1, _c.cam_rotation);
_c.cam_yscale = lengthdir_y(1, _c.cam_pitch);
_c.cam_zscale = lengthdir_x(1, _c.cam_pitch);

// Create recorder
//recorder = instance_create_layer(0, 0, "Instances", obj_recorder);

// Pre-generate background details (pebbles + foliage bumps)
// Save and restore RNG seed so background doesn't eat gameplay randomness
var _save_seed = random_get_seed();
random_set_seed(99999);

pebble_count = 40;
pebble_x = array_create(pebble_count);
pebble_y = array_create(pebble_count);
pebble_r = array_create(pebble_count);
for (var i = 0; i < pebble_count; i++) {
    pebble_x[i] = irandom_range(20, room_width - 20);
    pebble_y[i] = irandom_range(20, room_height - 20);
    pebble_r[i] = irandom_range(2, 5);
}

// Foliage border bumps
var border = 18;
var bump_step = 20;
foliage_bumps = [];
// Top
for (var bx = 0; bx < room_width; bx += bump_step) {
    array_push(foliage_bumps, { fx: bx + irandom(6), fy: border + irandom(4), fr: irandom_range(6, 12) });
}
// Bottom
for (var bx = 0; bx < room_width; bx += bump_step) {
    array_push(foliage_bumps, { fx: bx + irandom(6), fy: room_height - border - irandom(4), fr: irandom_range(6, 12) });
}
// Left
for (var by = 0; by < room_height; by += bump_step) {
    array_push(foliage_bumps, { fx: border + irandom(4), fy: by + irandom(6), fr: irandom_range(6, 12) });
}
// Right
for (var by = 0; by < room_height; by += bump_step) {
    array_push(foliage_bumps, { fx: room_width - border - irandom(4), fy: by + irandom(6), fr: irandom_range(6, 12) });
}

// Corner clusters
foliage_corners = [];
var corner_pts = [[0, 0], [room_width, 0], [0, room_height], [room_width, room_height]];
for (var c = 0; c < 4; c++) {
    for (var j = 0; j < 5; j++) {
        array_push(foliage_corners, {
            fx: corner_pts[c][0] + irandom_range(-20, 20),
            fy: corner_pts[c][1] + irandom_range(-20, 20),
            fr: irandom_range(10, 20)
        });
    }
}

random_set_seed(_save_seed);