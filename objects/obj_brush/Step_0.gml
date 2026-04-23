// Clean up expired walls
for (var i = ds_list_size(active_walls) - 1; i >= 0; i--) {
    var wall = active_walls[| i];
    wall.lifetime -= 1;
    
    if (wall.lifetime <= 0) {
        // Unfreeze stingers when wall expires
        for (var j = 0; j < ds_list_size(wall.frozen_stingers); j++) {
            var s = wall.frozen_stingers[| j];
            if (instance_exists(s)) {
                s.speed = s.frozen_speed;
            }
        }
        
        ds_list_destroy(wall.frozen_stingers);
        ds_list_delete(active_walls, i);
    }
}

// Check for stingers hitting existing walls
for (var i = 0; i < ds_list_size(active_walls); i++) {
    var wall = active_walls[| i];
    
    with (obj_stinger) {
        // Skip if already frozen by this wall
        var already_frozen = false;
        for (var j = 0; j < ds_list_size(wall.frozen_stingers); j++) {
            if (wall.frozen_stingers[| j] == id) {
                already_frozen = true;
                break;
            }
        }
        
        if (!already_frozen && speed > 0) {
            var dist = point_distance_to_line(x, y, wall.x1, wall.y1, wall.x2, wall.y2);
            if (dist < 10) {
                frozen_speed = speed;
                speed = 0;
                ds_list_add(wall.frozen_stingers, id);
                show_debug_message("Stinger caught by existing wall!");
            }
        }
    }
}

// Get mouse position from obj_game
var mx = obj_game.mouse_clamped_x;
var my = obj_game.mouse_clamped_y;

// Can't draw without ink
if (ink_current <= 0) {
    if (brush_drawing) {
        brush_drawing = false;
        brush_circles_completed = 0;
        ds_list_clear(brush_points);
    }
    return;  // Exit early
}

// Drain ink while drawing
if (brush_drawing) {
    ink_current -= ink_drain_rate;
    ink_current = max(0, ink_current);
}

// Start drawing
if (is_draw_pressed()) {
    brush_drawing = true;
    ds_list_clear(brush_points);
    ds_list_add(brush_points, mx, my);
}

// Continue drawing
if (brush_drawing && is_draw_held()) {
    var last_index = ds_list_size(brush_points) - 2;
    
    if (last_index >= 0) {
        var last_x = brush_points[| last_index];
        var last_y = brush_points[| last_index + 1];
        var dist = point_distance(last_x, last_y, mx, my);
        
        if (dist > 5) {
            ds_list_add(brush_points, mx, my);
            
            var num_points = ds_list_size(brush_points) / 2;
            if (num_points >= 10) {
                var intersection = scr_path_has_intersection(brush_points);
                
                if (intersection[0]) {
                    var loop = scr_extract_loop(brush_points, intersection[1], intersection[2], intersection[3], intersection[4]);
                    
                    // SHIELD CHECK
                    if (instance_exists(player) && point_in_polygon(player.x, player.y, loop)) {
                        var shield = instance_create_layer(0, 0, "Instances", obj_shield_flash);
                        shield.polygon_points = loop;
                        shield.lifetime = cfg("zones.shield_lifetime");
                        
                        with (obj_stinger) {
                            if (point_in_polygon(x, y, loop)) {
                                instance_destroy();
                            }
                        }
                        with (obj_enemy_base) {
                            if (point_in_polygon(x, y, loop)) {
                                instance_destroy();
                            }
                        }
                        
                        show_debug_message("SHIELD ACTIVATED!");
                        ink_current = 0;  // Empty all ink
                    }
                    else {
                        brush_circles_completed += 1;
                        
                        if (brush_circles_completed < 3) {
                            var zone = instance_create_layer(0, 0, "Instances", obj_slow_zone);
                            zone.polygon_points = loop;
                            zone.is_freeze_zone = false;
                            zone.lifetime = cfg("zones.slow_lifetime");
                            
                            with (obj_enemy_base) {
                                if (point_in_polygon(x, y, loop)) {
                                    slow_level = min(slow_level + 1, 3);
                                    slow_timer = slow_duration;
                                    vulnerability_timer = 0;
                                }
                            }
                        } else {
                            var zone = instance_create_layer(0, 0, "Instances", obj_slow_zone);
                            zone.polygon_points = loop;
                            zone.is_freeze_zone = true;
                            zone.lifetime = cfg("zones.freeze_lifetime");
                            ink_current = 0;  // Empty all ink on circle 3
                            
                            with (obj_stinger) {
                                if (point_in_polygon(x, y, loop)) {
                                    zone.meteor_stinger_count++;
                                    instance_destroy();
                                }
                            }
                            
                            if (zone.meteor_stinger_count > 0) {
                                with (obj_enemy_base) {
                                    if (point_in_polygon(x, y, loop)) {
                                        zone.meteor_enemy_count++;
                                        instance_destroy();
                                    }
                                }
                                
                                zone.is_meteor = true;
                                zone.meteor_moving = false;
                                
                                var sum_x = 0, sum_y = 0, count = 0;
                                for (var i = 0; i < ds_list_size(loop); i += 2) {
                                    sum_x += loop[| i];
                                    sum_y += loop[| i + 1];
                                    count++;
                                }
                                zone.meteor_x = sum_x / count;
                                zone.meteor_y = sum_y / count;
                            } else {
                                with (obj_enemy_base) {
                                    if (point_in_polygon(x, y, loop)) {
                                        slow_level = 3;
                                        slow_timer = slow_duration;
                                        vulnerability_timer = 0;
                                    }
                                }
                            }
                        }
                        
                        show_debug_message("Loop " + string(brush_circles_completed) + " detected!");
                    }
                    
                    ds_list_clear(brush_points);
                    ds_list_add(brush_points, intersection[3], intersection[4]);
                }
            }
        }
    } else {
        ds_list_add(brush_points, mx, my);
    }
}

// Stop drawing - check for walls
if (brush_drawing && is_draw_released()) {
    var num_points = ds_list_size(brush_points) / 2;
    
    if (num_points >= 5) {
        var start_x = brush_points[| 0];
        var start_y = brush_points[| 1];
        var end_x = brush_points[| ds_list_size(brush_points) - 2];
        var end_y = brush_points[| ds_list_size(brush_points) - 1];
        
        var direct_dist = point_distance(start_x, start_y, end_x, end_y);
        
        var path_dist = 0;
        for (var i = 0; i < ds_list_size(brush_points) - 2; i += 2) {
            path_dist += point_distance(brush_points[| i], brush_points[| i + 1], 
                                       brush_points[| i + 2], brush_points[| i + 3]);
        }
        
        if (direct_dist > cfg("walls.min_length") && (direct_dist / path_dist) > cfg("walls.straightness_threshold")) {
            var wall = {
                x1: start_x,
                y1: start_y,
                x2: end_x,
                y2: end_y,
                lifetime: cfg("walls.lifetime"),
                frozen_stingers: ds_list_create()
            };
            
            with (obj_stinger) {
                var dist = point_distance_to_line(x, y, wall.x1, wall.y1, wall.x2, wall.y2);
                if (dist < cfg("walls.catch_distance")) {
                    frozen_speed = speed;
                    speed = 0;
                    ds_list_add(wall.frozen_stingers, id);
                }
            }
            
            ds_list_add(active_walls, wall);
            show_debug_message("WALL created! Caught " + string(ds_list_size(wall.frozen_stingers)) + " stingers");
        }
    }
    
    brush_drawing = false;
    brush_circles_completed = 0;
    ds_list_clear(brush_points);
}

// Update previous states for press detection
replay_left_prev = replay_left_held;
replay_right_prev = replay_right_held;