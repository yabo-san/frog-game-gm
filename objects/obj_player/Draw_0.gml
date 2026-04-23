/// Frog — green body, yellow eyes that track the mouse
// if (global.view_mode == "fp") exit;

// Blink during invulnerability (skip if held at low value like test gym)
if (invuln_timer > 3 && (invuln_timer mod 6) < 3) exit;

var gz = 12;

// Direction toward mouse for eye tracking
var look_dir = point_direction(x, y, obj_game.mouse_game_x, obj_game.mouse_game_y);
var look_dist = min(point_distance(x, y, obj_game.mouse_game_x, obj_game.mouse_game_y), 60);
var look_t = look_dist / 60;  // 0 = mouse on frog, 1 = far away
var pupil_shift = look_t * 2.5;  // how far pupils offset from eye center

// Shadow
circle_3d(x, y, 0, 10, c_gray);

// Body
circle_3d(x, y, gz, 12, c_green);

// Belly
circle_3d(x, y, gz - 2, 8, c_lime);

// Eyes — shift slightly toward mouse
var eye_shift_x = lengthdir_x(look_t * 1, look_dir);
var eye_shift_y = lengthdir_y(look_t * 1, look_dir);
var le_x = x - 4 + eye_shift_x;
var le_y = y + eye_shift_y;
var re_x = x + 4 + eye_shift_x;
var re_y = y + eye_shift_y;

circle_3d(le_x, le_y, gz + 10, 5, c_yellow);
circle_3d(re_x, re_y, gz + 10, 5, c_yellow);

// Pupils — shift more toward mouse
var pupil_dx = lengthdir_x(pupil_shift, look_dir);
var pupil_dy = lengthdir_y(pupil_shift, look_dir);
circle_3d(le_x + pupil_dx, le_y + pupil_dy, gz + 11, 2, c_black);
circle_3d(re_x + pupil_dx, re_y + pupil_dy, gz + 11, 2, c_black);
