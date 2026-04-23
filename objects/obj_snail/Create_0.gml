event_inherited();
points = enemy_cfg("snail", "points");
move_speed = enemy_cfg("snail", "move_speed");
eatable = false;  // snail is NEVER eatable — killed by stingers only
reaction_parried = enemy_cfg("snail", "reaction_parried");
contact_damage = enemy_cfg("snail", "contact_damage");

sprite_index = global.spr_snail_mask;
mask_index = global.spr_snail_mask;
sprite_normal = global.spr_snail_mask;
sprite_eatable = global.spr_snail_mask;

// Shell state — tongue knocks it back and it hides
in_shell = false;
shell_timer = 0;
shell_duration = enemy_cfg("snail", "shell_duration");
knockback_force = enemy_cfg("snail", "knockback_force");
knockback_dx = 0;
knockback_dy = 0;
