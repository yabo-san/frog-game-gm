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
global.pickup_chain = 0;
global.current_chain = 0;

player = noone;
brush = noone;

enemy_spawn_timer = 0;
enemy_spawn_rate = cfg("enemies.spawn_rate");  // was 120

random_seed = 12345;
random_set_seed(random_seed);

// --- Setup display ---
var cam = camera_create_view(0, 0, 640, 480);
camera_set_view_size(cam, 640, 480);
camera_set_view_pos(cam, 0, 0);
view_camera[0] = cam;

surface_resize(application_surface, 640, 480);
window_set_size(640 * 2, 480 * 2);
gpu_set_tex_filter(false);
window_set_cursor(cr_none);

// Virtual mouse starts at center
mouse_game_x = 320;
mouse_game_y = 240;

// For fullscreen mode
is_fullscreen = false;

// Create recorder
recorder = instance_create_layer(0, 0, "Instances", obj_recorder);