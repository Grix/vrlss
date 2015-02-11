
/*if (keyboard_check(ord('Y')))
    {
    if (mouse_wheel_up()) obj_scanner.alpha += 0.02;
    if (mouse_wheel_down()) obj_scanner.alpha -= 0.02;
    }
    
    
if (keyboard_check(ord('Q')))
    {
    controller.rwidth -= ((display_mouse_get_x()) - display_get_width() /2) /5;
    controller.rlength -= ((display_mouse_get_y()) - display_get_height() /2) /5;
    if (mouse_wheel_up()) controller.rheight += 12;
    if (mouse_wheel_down()) controller.rheight -= 12;
    }
else*/
    
    direction -= ((display_mouse_get_x()) - display_get_width() /2) /4;
    pitch -= ((display_mouse_get_y()) - display_get_height() /2) /4;
    

if (pitch >= 85) pitch = 85;
if (pitch <= -85) pitch = -85;

display_mouse_set(display_get_width() / 2, display_get_height() / 2); 