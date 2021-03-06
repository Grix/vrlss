//draws the current frame on the screen
if (!ildaloaded)
    exit;

ild_list = ds_list_find_value(scan_list,argument0);
list_id = ds_list_find_value(ild_list,10+frame);

if (ds_list_size(list_id) < 2)
    exit;
        
list_size = (ds_list_size(list_id)-1);
np_pos = 1;

xpn = ds_list_find_value(list_id,np_pos)/$ffff*256;
ypn = ds_list_find_value(list_id,np_pos+1)/$ffff*256;
if (xpn >= 128)
    xpn -= 128;
else
    xpn += 128;
if (ypn >= 128)
    ypn -= 128;
else
    ypn += 128;
ypn = 256-ypn;

np_pos = 5;
    
while (np_pos < list_size)
    {
    
    blank = ds_list_find_value(list_id,np_pos+2);
    blank = (blank >> 6) & 1;
    
    //find point
    xp = xpn;
    yp = ypn;
    
    //find next point
    xpn = ds_list_find_value(list_id,np_pos)/$ffff*256;
    ypn = ds_list_find_value(list_id,np_pos+1)/$ffff*256;
    if (xpn >= 128)
        xpn -= 128;
    else
        xpn += 128;
    if (ypn >= 128)
        ypn -= 128;
    else
        ypn += 128;
    ypn = 256-ypn;
        
    //if blanking bit is 0, draw line between the two points
    if !(blank)
        {
        draw_set_color(ds_list_find_value(list_id,np_pos+3));
        draw_line(xp,yp,xpn,ypn);
        }
    
    np_pos+=4;
    }
    
