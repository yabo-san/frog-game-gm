polygon_points = ds_list_create();
is_freeze_zone = false;
zone_color = c_lime; // Default green for slow zones

// Meteor system
is_meteor = false;
meteor_direction = 0;
meteor_speed = 0;
bounces_remaining = 0;
meteor_x = 0;  // Center of meteor
meteor_y = 0;

// Meteor tracking variables
meteor_stinger_count = 0;  // Will become speed multiplier
meteor_enemy_count = 0;    // Will become bounce count
