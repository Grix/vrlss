if (global.IsRiftInitialized)
    {
    if (keyboard_check(ord('W')))
        {
        var temp = Rift_GetTrackingYPR();
        y += (cos(temp[0]+Yaw)*0.25);
        x += (sin(temp[0]+Yaw)*0.25);
        }
    if (keyboard_check(ord('A')))
        {
        var temp = Rift_GetTrackingYPR();
        y += (cos(temp[0]+Yaw-pi/2)*0.25);
        x += (sin(temp[0]+Yaw-pi/2)*0.25);
        }
    if (keyboard_check(ord('S')))
        {
        var temp = Rift_GetTrackingYPR();
        y -= (cos(temp[0]+Yaw)*0.25);
        x -= (sin(temp[0]+Yaw)*0.25);
        }
    if (keyboard_check(ord('D')))
        {
        var temp = Rift_GetTrackingYPR();
        y += (cos(temp[0]+Yaw+pi/2)*0.25);
        x += (sin(temp[0]+Yaw+pi/2)*0.25);
        }
    if (keyboard_check(ord('C')))
        {
        Y+=0.02;
        }
    if (keyboard_check(ord('V')))
        {
        Y-=0.02;
        }
    }
else    
    {
    if (keyboard_check(ord('W')))
        {
        x += (cos(Yaw)*0.025);
        y += (sin(Yaw)*0.025);
        }
    if (keyboard_check(ord('A')))
        {
        x += (cos(Yaw-pi/2)*0.025);
        y += (sin(Yaw-pi/2)*0.025);
        }
    if (keyboard_check(ord('S')))
        {
        x -= (cos(Yaw)*0.025);
        y -= (sin(Yaw)*0.025);
        }
    if (keyboard_check(ord('D')))
        {
        x += (cos(Yaw+pi/2)*0.025);
        y += (sin(Yaw+pi/2)*0.025);
        }
    if (keyboard_check(ord('C')))
        {
        Z+=0.02;
        }
    if (keyboard_check(ord('V')))
        {
        Z-=0.02;
        }
    }