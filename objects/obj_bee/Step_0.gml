event_inherited(); // run parent step (effects, movement, etc.)

// --- Count active stingers spawned by this bee ---
var bee_id = id; 
var active_stingers = 0;

with (obj_stinger) {
    if (owner == bee_id) {
        active_stingers += 1;
    }
}

// --- Update fire timer ---
if (!can_fire) {
    fire_timer -= 1;
    if (fire_timer <= 0) {
        can_fire = true;
    }
}

// --- Fire logic ---
if (can_fire && instance_exists(obj_player) && active_stingers < max_active_stingers) {
    var s = instance_create_layer(x, y, "Instances", obj_stinger);
    // s.speed = 5;
    s.direction = point_direction(x, y, obj_player.x, obj_player.y);
    s.image_angle = s.direction; 
    s.owner = bee_id;
    can_fire = false;
    fire_timer = fire_cooldown;
}

// --- Movement toward player ---
if (instance_exists(obj_player)) {
    var dx = obj_player.x - x;
    var dy = obj_player.y - y;
    var dist = point_distance(x, y, obj_player.x, obj_player.y);

    if (dist > 0) {
        x += (dx / dist) * move_speed * speed_mult;
        y += (dy / dist) * move_speed * speed_mult;
    }
}
