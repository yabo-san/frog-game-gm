event_inherited();

points = enemy_cfg("spider", "points");
eatable = enemy_cfg("spider", "eatable");
move_speed = enemy_cfg("spider", "move_speed");
reaction_parried = enemy_cfg("spider", "reaction_parried");

sprite_normal = global.spr_spider;
sprite_eatable = global.spr_spider;
sprite_index = global.spr_spider;

// Web axis assigned by spawner ("vertical" or "horizontal")
web_axis = "vertical";

// Random walk (like fly)
move_timer = irandom_range(60, 120);
stop_timer = 0;
move_direction = irandom(359);

// Spawn web
web = instance_create_layer(x, y, "Instances", obj_web);
web.spider = id;
web.axis = web_axis;
