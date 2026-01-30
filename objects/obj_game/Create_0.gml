// --- Gameplay globals ---
global.game_score = 0;
global.rank = 1;
global.pickup_chain = 0;
global.current_chain = 0;

player = noone;

enemy_spawn_timer = 0;
enemy_spawn_rate = 120;

brush_drawing = false;
brush_points = ds_list_create();
brush_circles_completed = 0;

random_set_seed(12345);

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