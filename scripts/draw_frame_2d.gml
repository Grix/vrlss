//draws the current frame on the screen

p = 0;
ild_list = ds_list_find_value(scan_list,argument0);
list_id = ds_list_find_value(ild_list,frame);
format = ds_list_find_value(list_id,2);

switch (format)
    {
    case 0: //format 0: old 3d
        {
        while (p < ds_list_size(list_id)/4-2)
            {
            blank = (ds_list_find_value(list_id,5+(p)*4+3) >> 14) & 1
            
            //find next point
            xpn = ds_list_find_value(list_id,5+(p+1)*4)/$ffff*800;
            ypn = ds_list_find_value(list_id,5+(p+1)*4+1)/$ffff*600;
            if (xpn >= 400)
                xpn -= 400;
            else
                xpn += 400;
            if (ypn >= 300)
                ypn -= 300;
            else
                ypn += 300;
            //ypn = 600-ypn;
            xpn = 800-xpn;
            
            //find point
            xp = ds_list_find_value(list_id,5+(p)*4)/$ffff*800;
            yp = ds_list_find_value(list_id,5+(p)*4+1)/$ffff*600;
        
            if (xp >= 400)
                xp -= 400;
            else
                xp += 400;
            if (yp >= 300)
                yp -= 300;
            else
                yp += 300;
            //yp = 600-yp;
            xp = 800-xp;
                
            //if blanking bit is 0, draw line between the two points
            if !(blank)
                {
                color = (ds_list_find_value(list_id,5+(p)*4+3)) & $FF;
                draw_set_color(make_color_rgb(ds_grid_get(palette_grid,0,color),ds_grid_get(palette_grid,1,color),ds_grid_get(palette_grid,2,color)));
                draw_line(xp,yp,xpn,ypn);
                }
            
            p++;
            }
        }
        break;
    case 4: //format 4: new 3d
        {
        while (p < ds_list_size(list_id)/7-2)
            {
            np = p+1;
                
            blank = ds_list_find_value(list_id,5+(np)*7+3);
            blank = (blank >> 6) & 1
            
            //find next point
            xpn = ds_list_find_value(list_id,5+(np)*7)/$ffff*800;
            ypn = ds_list_find_value(list_id,5+(np)*7+1)/$ffff*600;
            if (xpn >= 400)
                xpn -= 400;
            else
                xpn += 400;
            if (ypn >= 300)
                ypn -= 300;
            else
                ypn += 300;
            //ypn = 600-ypn;
            xpn = 800-xpn;
            
            //find point
            xp = ds_list_find_value(list_id,5+(p)*7)/$ffff*800;
            yp = ds_list_find_value(list_id,5+(p)*7+1)/$ffff*600;
        
            if (xp >= 400)
                xp -= 400;
            else
                xp += 400;
            if (yp >= 300)
                yp -= 300;
            else
                yp += 300;
            //yp = 600-yp;
            xp = 800-xp;
                
            //if blanking bit is 0, draw line between the two points
            if !(blank)
                {
                blue = ds_list_find_value(list_id,5+(np)*7+4);
                green = ds_list_find_value(list_id,5+(np)*7+5);
                red = ds_list_find_value(list_id,5+(np)*7+6);
                draw_set_color(make_color_rgb(red,green,blue));
                draw_line(xp,yp,xpn,ypn);
                }
            
            p++;
            }
        }
        break;
    case 5: //format 5: new 2d
        {
        while (p < ds_list_size(list_id)/6-2)
            {
            np = p+1;
                
            blank = ds_list_find_value(list_id,5+(np)*6+2);
            blank = (blank >> 6) & 1
            
            //find next point
            xpn = ds_list_find_value(list_id,5+(np)*6)/$ffff*800;
            ypn = ds_list_find_value(list_id,5+(np)*6+1)/$ffff*600;
            if (xpn >= 400)
                xpn -= 400;
            else
                xpn += 400;
            if (ypn >= 300)
                ypn -= 300;
            else
                ypn += 300;
            //ypn = 600-ypn;
            xpn = 800-xpn;
            
            //find point
            xp = ds_list_find_value(list_id,5+(p)*6)/$ffff*800;
            yp = ds_list_find_value(list_id,5+(p)*6+1)/$ffff*600;
        
            if (xp >= 400)
                xp -= 400;
            else
                xp += 400;
            if (yp >= 300)
                yp -= 300;
            else
                yp += 300;
            //yp = 600-yp;
            xp = 800-xp;
                
            //if blanking bit is on, draw line between the two points
            if !(blank)
                {
                blue = ds_list_find_value(list_id,5+(np)*6+3);
                green = ds_list_find_value(list_id,5+(np)*6+4);
                red = ds_list_find_value(list_id,5+(np)*6+5);
                draw_set_color(make_color_rgb(red,green,blue));
                draw_line(xp,yp,xpn,ypn);
                }
            
            p++;
            }
        }
        break;
    }
