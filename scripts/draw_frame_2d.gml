//draws the current frame on the screen

np=0;p=0;
ild_list = ds_list_find_value(scan_list,argument0);
list_id = ds_list_find_value(ild_list,frame);
format = ds_list_find_value(list_id,2);

switch (format)
    {
    case 4: //format 4: new 3d
        {
        list_size = (ds_list_size(list_id)-5);
        np_pos = 5;
        
        xpn = ds_list_find_value(list_id,np_pos)/$ffff*600;
        ypn = ds_list_find_value(list_id,np_pos+1)/$ffff*600;
        //xpn = parse_word(xpn);
        //ypn = parse_word(ypn);
        if (xpn >= 300)
            xpn -= 300;
        else
            xpn += 300;
        if (ypn >= 300)
            ypn -= 300;
        else
            ypn += 300;
        ypn = 600-ypn;
        //xpn = 600-xpn;
        
        np_pos = 12;
            
        while (np_pos < list_size)
            {
            
            blank = ds_list_find_value(list_id,np_pos+3);
            blank = (blank >> 6) & 1
            
            //find point
            xp = xpn;
            yp = ypn;
            
            //find next point
            xpn = ds_list_find_value(list_id,np_pos)/$ffff*600;
            ypn = ds_list_find_value(list_id,np_pos+1)/$ffff*600;
            //xpn = parse_word(xpn);
            //ypn = parse_word(ypn);
            if (xpn >= 300)
                xpn -= 300;
            else
                xpn += 300;
            if (ypn >= 300)
                ypn -= 300;
            else
                ypn += 300;
            ypn = 600-ypn;
            //xpn = 600-xpn;
                
            //if blanking bit is 0, draw line between the two points
            if !(blank)
                {
                blue = ds_list_find_value(list_id,np_pos+4);
                green = ds_list_find_value(list_id,np_pos+5);
                red = ds_list_find_value(list_id,np_pos+6);
                draw_set_color(make_color_rgb(red,green,blue));
                draw_line(xp,yp,xpn,ypn);
                }
            
            np_pos+=7;
            }
         break;
        }
       
    case 5: //format 5: new 2d
        {
        list_size = (ds_list_size(list_id)-5)/6;
        np_pos = 5+(np)*7;
        
        xpn = ds_list_find_value(list_id,np_pos)/6.825;
        ypn = ds_list_find_value(list_id,np_pos+1)/6.825;
        //xpn = parse_word(xpn);
        //ypn = parse_word(ypn);
        if (xpn >= 300)
            xpn -= 300;
        else
            xpn += 300;
        if (ypn >= 300)
            ypn -= 300;
        else
            ypn += 300;
        ypn = 600-ypn;
        //xpn = 600-xpn;
            
        while (p < list_size)
            {
            np_pos = 5+(np)*6;
            
            blank = ds_list_find_value(list_id,np_pos+2);
            blank = (blank >> 6) & 1
            
            //find point
            xp = xpn;
            yp = ypn;
            
            //find next point
            xpn = ds_list_find_value(list_id,np_pos)/6.825;
            ypn = ds_list_find_value(list_id,np_pos+1)/6.825;
            //xpn = parse_word(xpn);
            //ypn = parse_word(ypn);
            if (xpn >= 300)
                xpn -= 300;
            else
                xpn += 300;
            if (ypn >= 300)
                ypn -= 300;
            else
                ypn += 300;
            ypn = 600-ypn;
            //xpn = 600-xpn;
                
            //if blanking bit is 0, draw line between the two points
            if !(blank)
                {
                blue = ds_list_find_value(list_id,np_pos+3);
                green = ds_list_find_value(list_id,np_pos+4);
                red = ds_list_find_value(list_id,np_pos+5);
                draw_set_color(make_color_rgb(red,green,blue));
                draw_line(xp,yp,xpn,ypn);
                }
            
            p++;
            np++;
            }
         break;
        }
        
    case 0: //format 0: old 3d
        {
        while (p < ds_list_size(list_id)/4-2)
            {
            blank = (ds_list_find_value(list_id,5+(p)*4+3) >> 14) & 1
            
            //find next point
            xpn = ds_list_find_value(list_id,5+(p+1)*4)/6.825;
            ypn = ds_list_find_value(list_id,5+(p+1)*4+1)/6.825;
            //xpn = parse_word(xpn);
            //ypn = parse_word(ypn);
            if (xpn >= 300)
                xpn -= 300;
            else
                xpn += 300;
            if (ypn >= 300)
                ypn -= 300;
            else
                ypn += 300;
            ypn = 600-ypn;
            xpn = 600-xpn;
            
            //find point
            xp = ds_list_find_value(list_id,5+(p)*4)/6.825;
            yp = ds_list_find_value(list_id,5+(p)*4+1)/6.825;
            //xp = parse_word(xp);
            //yp = parse_word(yp);
            if (xp >= 300)
                xp -= 300;
            else
                xp += 300;
            if (yp >= 300)
                yp -= 300;
            else
                yp += 300;
            yp = 600-yp;
            xp = 600-xp;
                
            //if blanking bit is 0, draw line between the two points
            if !(blank)
                {
                color = (ds_list_find_value(list_id,5+(p)*4+3)) & $FF;
                draw_set_color(make_color_rgb(ds_grid_get(palette_grid,0,color),ds_grid_get(palette_grid,1,color),ds_grid_get(palette_grid,2,color)));
                draw_line(xp,yp,xpn,ypn);
                }
            
            p++;
            }
        break;
        }
        
    }