sprite_index = global.spr_player_mask;
mask_index = global.spr_player_mask;

follow_speed = cfg("player.follow_speed");

// Tongue reference (initialized safely in Step)
tongue = noone;

invuln_timer = 0;
invuln_duration = cfg("player.invuln_frames");
