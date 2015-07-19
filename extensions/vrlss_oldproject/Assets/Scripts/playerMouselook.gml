
/*if (keyboard_check(ord('Y')))
    {
    if (mouse_wheel_up()) obj_scanner.alpha += 0.02;
    if (mouse_wheel_down()) obj_scanner.alpha -= 0.02;
    }
*/
    
yaw -= ((display_mouse_get_x()) - display_get_width() /2) /4;
pitch -= ((display_mouse_get_y()) - display_get_height() /2) /4;

if (pitch >= 85) pitch = 85;
if (pitch <= -85) pitch = -85;

display_mouse_set(display_get_width() / 2, display_get_height() / 2); 