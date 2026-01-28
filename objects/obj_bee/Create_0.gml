event_inherited();
can_fire = true;       // ready to fire
fire_cooldown = 120;   // frames between shots
fire_timer = 0;        // counts down when on cooldown
max_active_stingers = 1; // max stingers allowed at once
eatable = true
reaction_parried = "immune"; // cannot be affected by stingers

sprite_normal = spr_bee;
sprite_eatable = spr_bee_eatable;