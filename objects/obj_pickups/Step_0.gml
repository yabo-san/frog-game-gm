if (place_meeting(x, y, obj_player)) {
    if (pickup_type == "ink") obj_paintbrush.effect_bonus += 1;
    if (pickup_type == "bomb") obj_bomb.charge_rate += 1;
    if (pickup_type == "speed") obj_player.follow_speed += 0.05;

    with (obj_game) {
        pickup_chain++;
        if (pickup_chain % 3 == 0) rank++;
    }
    instance_destroy();
}
