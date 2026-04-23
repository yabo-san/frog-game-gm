/// @description wp_to_sp(x, y, z) — world position to screen position
/// Sets: res_screen_x, res_screen_y, res_screen_z, res_screen_scale
function wp_to_sp(_x, _y, _z) {
    var cam = global.cam;

    res_screen_x = _x;
    res_screen_y = _y;
    res_screen_z = _z;

    // translate to camera space
    res_screen_x -= cam.cam_x + cam.cam_width / 2;
    res_screen_y -= cam.cam_y + cam.cam_height / 2;
    res_screen_z -= cam.cam_z;

    // rotation (XY plane)
    var xp = res_screen_x;
    res_screen_x = xp * cam.m00 + res_screen_y * cam.m10;
    res_screen_y = xp * cam.m01 + res_screen_y * cam.m11;

    // pitch (YZ plane)
    var yp = res_screen_y;
    res_screen_y = yp * cam.cam_yscale - res_screen_z * cam.cam_zscale;
    res_screen_z = -yp * cam.cam_zscale - res_screen_z * cam.cam_yscale;

    // perspective
    res_screen_scale = (res_screen_z - cam.cam_near) * cam.farnear_comp;
    res_screen_scale += (1 - res_screen_scale) * cam.cam_fov;
    res_screen_scale = cam.cam_zoom / res_screen_scale;

    // scale position by perspective
    res_screen_x *= res_screen_scale;
    res_screen_y *= res_screen_scale;

    // translate back to screen center
    res_screen_x += cam.cam_width / 2;
    res_screen_y += cam.cam_height / 2;
}

/// @description sp_to_wp(screen_x, screen_y) — screen position to world position on ground (z=0)
/// Sets: res_world_x, res_world_y
function sp_to_wp(_sx, _sy) {
    var cam = global.cam;

    // Remove center offset
    var sx = _sx - cam.cam_width / 2;
    var sy = _sy - cam.cam_height / 2;

    // For a point on the ground (z=0), solve the inverse transform
    // With rotation=0 and near=0:
    var p = -cam.cam_zscale;           // z_scr coefficient for y_cam
    var q = cam.cam_z * cam.cam_yscale; // z_scr constant
    var r = cam.cam_yscale;            // y_scr coefficient for y_cam
    var s = cam.cam_z * cam.cam_zscale; // y_scr constant

    var A = cam.farnear_comp * (1 - cam.cam_fov);
    var B = cam.cam_fov;
    var C = cam.cam_zoom;

    // Solve: y_cam = (s*C - sy*(q*A + B)) / (sy*p*A - r*C)
    var denom = sy * p * A - r * C;
    if (abs(denom) < 0.001) denom = 0.001;
    var y_cam = (s * C - sy * (q * A + B)) / denom;

    // Now compute scale from y_cam
    var z_scr = y_cam * p + q;
    var adj_scale = z_scr * A + B;
    var scale = C / adj_scale;

    // Solve for x_cam
    var x_cam = sx / scale;

    // Convert back to world coords
    res_world_x = x_cam + cam.cam_x + cam.cam_width / 2;
    res_world_y = y_cam + cam.cam_y + cam.cam_height / 2;
}
