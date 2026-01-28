/// @func scr_parry(stinger, tongue_direction)
/// @desc Parries a stinger, making it fly in the tongue's direction
/// @param stinger  The stinger instance to parry
/// @param tongue_direction  The direction the tongue was moving
function scr_parry(stinger, tongue_direction) {
    stinger.parried = true;
    stinger.homing = false;
    
    // Inherit the tongue's direction at moment of parry
    stinger.direction = tongue_direction;
    stinger.image_angle = stinger.direction;
    
    // Optional: boost speed when parried
    // stinger.speed *= 1.5;
}