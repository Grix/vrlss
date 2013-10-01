if (keyboard_check(ord('Q')))
    {
    controller.rwidth -= ((display_mouse_get_x()) - display_get_width() /2) /5;
    controller.rlength -= ((display_mouse_get_y()) - display_get_height() /2) /5;
    if (mouse_wheel_up()) controller.rheight += 12;
    if (mouse_wheel_down()) controller.rheight -= 12;
    }
else if (keyboard_check(ord('R')))
    {
    obj_scanner.x -= ((display_mouse_get_x()) - display_get_width() /2) /5;
    obj_scanner.y -= ((display_mouse_get_y()) - display_get_height() /2) /5;
    if (instance_exists(obj_flankscanner))
        {
        obj_flankscanner.x -= ((display_mouse_get_x()) - display_get_width() /2) /5;
        obj_flankscanner.y -= ((display_mouse_get_y()) - display_get_height() /2) /5;
        obj_flankscanner1.x -= ((display_mouse_get_x()) - display_get_width() /2) /5;
        obj_flankscanner1.y -= ((display_mouse_get_y()) - display_get_height() /2) /5;
        }
    if (mouse_wheel_up()) obj_scanner.z += 7;
    if (mouse_wheel_down()) obj_scanner.z -= 7;
    }
else if (keyboard_check(ord('T')))
    {
    obj_scanner.dirver += ((display_mouse_get_x()) - display_get_width() /2) /1000;
    obj_scanner.dirhor -= ((display_mouse_get_y()) - display_get_height() /2) /1000;
    if (instance_exists(obj_flankscanner))
        {
    obj_flankscanner.dirver -= ((display_mouse_get_x()) - display_get_width() /2) /1000;
    obj_flankscanner.dirhor -= ((display_mouse_get_y()) - display_get_height() /2) /1000;
    obj_flankscanner1.dirver -= ((display_mouse_get_x()) - display_get_width() /2) /1000;
    obj_flankscanner1.dirhor -= ((display_mouse_get_y()) - display_get_height() /2) /1000;
        }
    if (mouse_wheel_up()) obj_scanner.scanmulti += 0.03;
    if (mouse_wheel_down()) obj_scanner.scanmulti -= 0.03;
    }
else if (keyboard_check(ord('F')) and (instance_exists(obj_flankscanner)))
    {
    obj_flankscanner.x -= ((display_mouse_get_x()) - display_get_width() /2) /5;
    obj_flankscanner.y -= ((display_mouse_get_y()) - display_get_height() /2) /5;
    if (mouse_wheel_up()) obj_flankscanner.z += 7;
    if (mouse_wheel_down()) obj_flankscanner.z -= 7;
    obj_flankscanner1.x += ((display_mouse_get_x()) - display_get_width() /2) /5;
    obj_flankscanner1.y -= ((display_mouse_get_y()) - display_get_height() /2) /5;
    if (mouse_wheel_up()) obj_flankscanner1.z += 7;
    if (mouse_wheel_down()) obj_flankscanner1.z -= 7;
    }
else if (keyboard_check(ord('G')) and (instance_exists(obj_flankscanner)))
    {
    obj_flankscanner.dirver -= ((display_mouse_get_x()) - display_get_width() /2) /1000;
    obj_flankscanner.dirhor -= ((display_mouse_get_y()) - display_get_height() /2) /1000;
    if (mouse_wheel_up()) obj_flankscanner.scanmulti += 0.03;
    if (mouse_wheel_down()) obj_flankscanner.scanmulti -= 0.03;
    obj_flankscanner1.dirver += ((display_mouse_get_x()) - display_get_width() /2) /1000;
    obj_flankscanner1.dirhor -= ((display_mouse_get_y()) - display_get_height() /2) /1000;
    if (mouse_wheel_up()) obj_flankscanner1.scanmulti += 0.03;
    if (mouse_wheel_down()) obj_flankscanner1.scanmulti -= 0.03;
    }
else
    {
    direction -= ((display_mouse_get_x()) - display_get_width() /2) /4;
    pitch -= ((display_mouse_get_y()) - display_get_height() /2) /4;
    }

if (pitch >= 85) pitch = 85;
if (pitch <= -85) pitch = -85;

display_mouse_set(display_get_width() / 2, display_get_height() / 2); 
