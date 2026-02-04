// Brush state
brush_drawing = false;
brush_points = ds_list_create();
brush_circles_completed = 0;

// Active walls
active_walls = ds_list_create();

// Reference to player (set by obj_game)
player = noone;