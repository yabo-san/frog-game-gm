event_inherited();

points = cfg("enemies.spider.points");
eatable = true;
move_speed = cfg("enemies.spider.move_speed");
reaction_parried = "damage";

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
