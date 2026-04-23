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
if (can_fire && instance_exists(obj_player) && active_stingers < max_active_stingers
    && x > 0 && x < room_width && y > 0 && y < room_height) {
    var s = instance_create_layer(x, y, "Instances", obj_stinger);
    // s.speed = 5;
    s.direction = point_direction(x, y, obj_player.x, obj_player.y);
    s.image_angle = s.direction; 
    s.owner = bee_id;
    can_fire = false;
    fire_timer = fire_cooldown;
}

// --- Movement toward player ---
//if (instance_exists(obj_player)) {
    //var dx = obj_player.x - x;
    //var dy = obj_player.y - y;
    //var dist = point_distance(x, y, obj_player.x, obj_player.y);
//
    //if (dist > 0) {
        //x += (dx / dist) * move_speed * speed_mult;
        //y += (dy / dist) * move_speed * speed_mult;
    //}
//}

// Random walk with edge steering
var margin = 40;
if (move_timer > 0) {
    x += lengthdir_x(move_speed * speed_mult, move_direction);
    y += lengthdir_y(move_speed * speed_mult, move_direction);
    move_timer -= 1;

    // Steer back toward center when near edges
    if (x < margin || x > room_width - margin || y < margin || y > room_height - margin) {
        move_direction = point_direction(x, y, room_width / 2, room_height / 2) + irandom_range(-45, 45);
    }

    x = clamp(x, 8, room_width - 8);
    y = clamp(y, 8, room_height - 8);

    if (move_timer <= 0) {
        stop_timer = irandom_range(30, 90);
    }
} else if (stop_timer > 0) {
    stop_timer -= 1;
    if (stop_timer <= 0) {
        move_direction = irandom(359);
        move_timer = irandom_range(60, 120);
    }
}