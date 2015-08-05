//draws the laser projecton for all the scanners
draw_set_color(c_white);
draw_enable_alphablend(1);
draw_set_blend_mode(bm_add);
d3d_set_culling(0);
d3d_set_lighting(0);
d3d_set_hidden(0);

for (i = 0;i <= (ds_list_size(controller.scan_list)-1);i++)
    {
    ild_list = ds_list_find_value(controller.scan_list,i);
    list_id = ds_list_find_value(ild_list,10+controller.frame);

    if (ds_list_size(list_id) < 2)
        continue;
        
    full_length = 8;
    half_length = full_length/2;
    format = ds_list_find_value(ild_list,9);
    scanner_x = ds_list_find_value(ild_list,1)/600*full_length;
    scanner_z = ds_list_find_value(ild_list,7)/600*full_length;
    scanner_y = ds_list_find_value(ild_list,2)/600*full_length;
    xrad = ds_list_find_value(ild_list,3);
    yrad = ds_list_find_value(ild_list,4);
    angle = ds_list_find_value(ild_list,6);
    alpha = ds_list_find_value(ild_list,5)*0.3;
    dual = ds_list_find_value(ild_list,0);
    pihalf = pi/2;
    anglemult = 6*angle;
    
    if (controller.fog) 
        {
        shader_set(lasershader);
        usealpha = alpha;
        shader_set_uniform_f(controller.u_time,controller.time);
        scanner_pos[0] = scanner_x;
        scanner_pos[1] = scanner_y;
        scanner_pos[2] = scanner_z;
        shader_set_uniform_f_array(controller.u_scanner_pos,scanner_pos);
        player_pos[0] = obj_player.X;
        player_pos[1] = obj_player.Y;
        player_pos[2] = obj_player.Z;
        shader_set_uniform_f_array(controller.u_player_pos,player_pos);
        }
    else
        {
        shader_set(normalshader);
        usealpha = alpha*1.1;
        }
    
    switch (format)
        {
        case 4: //format 4: new 3d
            {
            list_size = (ds_list_size(list_id)-1);
            np_pos = 1;
            
            xpn = ds_list_find_value(list_id,np_pos)/$ffff*full_length;
            ypn = ds_list_find_value(list_id,np_pos+1)/$ffff*full_length;
            if (xpn >= half_length)
                xpn -= half_length;
            else
                xpn += half_length;
            if (ypn >= half_length)
                ypn -= half_length;
            else
                ypn += half_length;
            //ypn = 10-ypn;
            ypn -= half_length;
            xpn -= half_length;
            //xpn = 1024-xpn;
            
            xpnpos = scanner_x+25*sin(pihalf-yrad-ypn/anglemult)*cos(pihalf-xrad-xpn/anglemult);
            zpnpos = scanner_z+25*sin(pihalf-yrad-ypn/anglemult)*sin(pihalf-xrad-xpn/anglemult);
            ypnpos = scanner_y+half_length/2+25*cos(pihalf-yrad-ypn/anglemult);
            
            np_pos = 8;
                
            while (np_pos < list_size)
                {   
                
                blank = ds_list_find_value(list_id,np_pos+3);
                blank = (blank >> 6) & 1;
                
                //find point
                xppos = xpnpos;
                yppos = ypnpos;
                zppos = zpnpos;
                xp = xpn;
                yp = ypn;
                
                //find next point
                xpn = ds_list_find_value(list_id,np_pos)/$ffff*full_length;
                ypn = ds_list_find_value(list_id,np_pos+1)/$ffff*full_length;
                //xpn = parse_word(xpn);
                //ypn = parse_word(ypn);
                if (xpn >= half_length)
                    xpn -= half_length;
                else
                    xpn += half_length;
                if (ypn >= half_length)
                    ypn -= half_length;
                else
                    ypn += half_length;
                //ypn = 10-ypn;
                ypn -= half_length;
                xpn -= half_length;
                
                //xpn = 1024-xpn;
                xpnpos = scanner_x+25*sin(pihalf-yrad-ypn/anglemult)*cos(pihalf-xrad-xpn/anglemult);
                zpnpos = scanner_y+25*sin(pihalf-yrad-ypn/anglemult)*sin(pihalf-xrad-xpn/anglemult);
                ypnpos = scanner_z+half_length/2+25*cos(pihalf-yrad-ypn/anglemult);
                    
                //if blanking bit is on, draw line between the two points
                if !(blank)
                    {
                    blue = ds_list_find_value(list_id,np_pos+4);
                    green = ds_list_find_value(list_id,np_pos+5);
                    red = ds_list_find_value(list_id,np_pos+6);
                    colormade = make_color_rgb(red,green,blue);
                    
                    if ((xpn == xp) && (ypn == yp))
                        {
                        draw_set_colour(colormade);
                        draw_set_alpha(usealpha*1.5);
                        d3d_primitive_begin_texture(pr_linelist,background_get_texture(bck_smoke));
                            d3d_vertex_texture(scanner_x,scanner_y,scanner_z,0,0);
                            d3d_vertex_texture(xppos,yppos,zppos,0,0);
                        d3d_primitive_end();
                        }
                    else
                        {
                        draw_set_colour(colormade);
                        draw_set_alpha(usealpha);
                        d3d_primitive_begin_texture(pr_trianglelist,background_get_texture(bck_smoke));
                            d3d_vertex_texture(scanner_x,scanner_y,scanner_z,0,0);
                            d3d_vertex_texture(xppos,yppos,zppos,0,0);
                            d3d_vertex_texture(xpnpos,ypnpos,zpnpos,0,0);
                        d3d_primitive_end();
                        }
                    }
                    
                if (dual)
                    {
                    xpnposdual = full_length-scanner_x+25*sin(pihalf-yrad-ypn/anglemult)*cos(-pihalf-xrad-xpn/anglemult);
                    xpposdual = full_length-scanner_x+25*sin(pihalf-yrad-yp/anglemult)*cos(-pihalf-xrad-xp/anglemult);
                        
                    //if blanking bit is off, draw line between the two points
                    if !(blank)
                        {
                        blue = ds_list_find_value(list_id,np_pos+4);
                        green = ds_list_find_value(list_id,np_pos+5);
                        red = ds_list_find_value(list_id,np_pos+6);
                        colormade = make_color_rgb(red,green,blue);
                        
                        if ((xpn == xp) && (ypn == yp))
                            {
                            draw_set_colour(colormade);
                            draw_set_alpha(usealpha*1.5);
                            d3d_primitive_begin_texture(pr_linelist,background_get_texture(bck_smoke));
                                d3d_vertex_texture(full_length-scanner_x,scanner_y,scanner_z,0,0);
                                d3d_vertex_texture(xpposdual,yppos,zppos,0,0);
                            d3d_primitive_end();
                            }
                        else
                            {
                            draw_set_colour(colormade);
                            draw_set_alpha(usealpha);
                            d3d_primitive_begin_texture(pr_trianglelist,background_get_texture(bck_smoke));
                                d3d_vertex_texture(full_length-scanner_x,scanner_y,scanner_z,0,0);
                                d3d_vertex_texture(xpposdual,yppos,zppos,0,0);
                                d3d_vertex_texture(xpnposdual,ypnpos,zpnpos,0,0);
                            d3d_primitive_end();
                            }
                        }
                    }
                
                np_pos+=7;
                }
            break;
            }
        case 5: //format 5: new 2d
            {
            list_size = (ds_list_size(list_id)-1);
            np_pos = 1;
            
            xpn = ds_list_find_value(list_id,np_pos)/$ffff*full_length;
            ypn = ds_list_find_value(list_id,np_pos+1)/$ffff*full_length;
            if (xpn >= half_length)
                xpn -= half_length;
            else
                xpn += half_length;
            if (ypn >= half_length)
                ypn -= half_length;
            else
                ypn += half_length;
            //ypn = 10-ypn;
            ypn -= half_length;
            xpn -= half_length;
            //xpn = 1024-xpn;
            
            xpnpos = scanner_x+25*sin(pihalf-yrad-ypn/anglemult)*cos(pihalf-xrad-xpn/anglemult);
            zpnpos = scanner_y+25*sin(pihalf-yrad-ypn/anglemult)*sin(pihalf-xrad-xpn/anglemult);
            ypnpos = scanner_z+half_length/2+25*cos(pihalf-yrad-ypn/anglemult);
            
            np_pos = 7;
                
            while (np_pos < list_size)
                {   
                
                blank = ds_list_find_value(list_id,np_pos+2);
                blank = (blank >> 6) & 1;
                
                //find point
                xppos = xpnpos;
                yppos = ypnpos;
                zppos = zpnpos;
                xp = xpn;
                yp = ypn;
                
                //find next point
                xpn = ds_list_find_value(list_id,np_pos)/$ffff*full_length;
                ypn = ds_list_find_value(list_id,np_pos+1)/$ffff*full_length;
                //xpn = parse_word(xpn);
                //ypn = parse_word(ypn);
                if (xpn >= half_length)
                    xpn -= half_length;
                else
                    xpn += half_length;
                if (ypn >= half_length)
                    ypn -= half_length;
                else
                    ypn += half_length;
                //ypn = 10-ypn;
                ypn -= half_length;
                xpn -= half_length;
                
                //xpn = 1024-xpn;
                xpnpos = scanner_x+25*sin(pihalf-yrad-ypn/anglemult)*cos(pihalf-xrad-xpn/anglemult);
                zpnpos = scanner_y+25*sin(pihalf-yrad-ypn/anglemult)*sin(pihalf-xrad-xpn/anglemult);
                ypnpos = scanner_z+half_length/2+25*cos(pihalf-yrad-ypn/anglemult);
                    
                //if blanking bit is off, draw line between the two points
                if !(blank)
                    {
                    blue = ds_list_find_value(list_id,np_pos+3);
                    green = ds_list_find_value(list_id,np_pos+4);
                    red = ds_list_find_value(list_id,np_pos+5);
                    colormade = make_color_rgb(red,green,blue);
                    
                    if ((xpn == xp) && (ypn == yp))
                        {
                        draw_set_colour(colormade);
                        draw_set_alpha(usealpha*1.5);
                        d3d_primitive_begin_texture(pr_linelist,background_get_texture(bck_smoke));
                            d3d_vertex_texture(scanner_x,scanner_y,scanner_z,0,0);
                            d3d_vertex_texture(xppos,yppos,zppos,0,0);
                        d3d_primitive_end();
                        }
                    else
                        {
                        draw_set_colour(colormade);
                        draw_set_alpha(usealpha);
                        d3d_primitive_begin_texture(pr_trianglelist,background_get_texture(bck_smoke));
                            d3d_vertex_texture(scanner_x,scanner_y,scanner_z,0,0);
                            d3d_vertex_texture(xppos,yppos,zppos,0,0);
                            d3d_vertex_texture(xpnpos,ypnpos,zpnpos,0,0);
                        d3d_primitive_end();
                        }
                    }
                    
                if (dual)
                    {
                    xpnposdual = full_length-scanner_x+25*sin(pihalf-yrad-ypn/anglemult)*cos(-pihalf-xrad-xpn/anglemult);
                    xpposdual = full_length-scanner_x+25*sin(pihalf-yrad-yp/anglemult)*cos(-pihalf-xrad-xp/anglemult);
                        
                    //if blanking bit is on, draw line between the two points
                    if !(blank)
                        {
                        blue = ds_list_find_value(list_id,np_pos+3);
                        green = ds_list_find_value(list_id,np_pos+4);
                        red = ds_list_find_value(list_id,np_pos+5);
                        colormade = make_color_rgb(red,green,blue);
                        
                        if ((xpn == xp) && (ypn == yp))
                            {
                            draw_set_colour(colormade);
                            draw_set_alpha(usealpha*1.5);
                            d3d_primitive_begin_texture(pr_linelist,background_get_texture(bck_smoke));
                                d3d_vertex_texture(full_length-scanner_x,scanner_y,scanner_z,0,0);
                                d3d_vertex_texture(xpposdual,yppos,zppos,0,0);
                            d3d_primitive_end();
                            }
                        else
                            {
                            draw_set_colour(colormade);
                            draw_set_alpha(usealpha);
                            d3d_primitive_begin_texture(pr_trianglelist,background_get_texture(bck_smoke));
                                d3d_vertex_texture(full_length-scanner_x,scanner_y,scanner_z,0,0);
                                d3d_vertex_texture(xpposdual,yppos,zppos,0,0);
                                d3d_vertex_texture(xpnposdual,ypnpos,zpnpos,0,0);
                            d3d_primitive_end();
                            }
                        }
                    }
                np_pos+=6;
                }
            break;
            }
        }
        
    shader_reset();  
    }
draw_set_blend_mode(bm_normal);
draw_set_alpha(1);
draw_set_colour(c_white);
