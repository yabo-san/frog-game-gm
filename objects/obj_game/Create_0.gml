// --- Gameplay globals ---
global.game_score = 0;
global.rank = 1;
global.pickup_chain = 0;
global.current_chain = 0;

// Player reference (deferred creation)
player = noone;


// Enemy spawn system
enemy_spawn_timer = 0;
enemy_spawn_rate = 120;

// Brush system
brush_drawing = false;
brush_points = ds_list_create();

random_set_seed(12345);

// --- Create a fixed camera ---
var cam = camera_create_view(0, 0, 640, 480);  // x, y, width, height
camera_set_view_size(cam, 640, 480);           // camera size
camera_set_view_pos(cam, 0, 0);               // lock at top-left
camera_set_view_target(cam, noone);           // do not follow anything

// Assign camera to view 0
view_camera[0] = cam;


// Hide the system cursor
window_set_cursor(cr_none);

// Start mouse in the middle of playfield
mouse_clamped_x = 320;
mouse_clamped_y = 240;
window_mouse_set(mouse_clamped_x, mouse_clamped_y);


