//draws the laser projecton for all the scanners


for (i = 0;i <= (ds_list_size(controller.scan_list)-1);i++)
    {
    ild_list = ds_list_find_value(controller.scan_list,i);
    list_id = ds_list_find_value(ild_list,10+controller.frame);

    if (ds_list_size(list_id) < 2)
        continue;
    
    format = ds_list_find_value(ild_list,9);
    scanner_x = GR_meterToPixel(ds_list_find_value(ild_list,1)/600*7);
    scanner_y = GR_meterToPixel(ds_list_find_value(ild_list,7)/600*7);
    scanner_z = GR_meterToPixel(ds_list_find_value(ild_list,2)/600*7);
    full_length = GR_meterToPixel(7);
    xrad = ds_list_find_value(ild_list,3);
    yrad = ds_list_find_value(ild_list,4);
    angle = ds_list_find_value(ild_list,6);
    alpha = ds_list_find_value(ild_list,5)*1.5;
    dual = ds_list_find_value(ild_list,0);
    pihalf = pi/2;
    anglemult = 4096*angle;
    
    draw_set_color(c_white);
    draw_set_alpha(1);
    draw_set_blend_mode_ext(bm_src_alpha,bm_dest_alpha);
    d3d_set_culling(false);
    if (controller.fog) 
        {
        shader_set(lasershader);
        alpha /= 0.5;
        playerdir_hor = degtorad(point_direction(scanner_x,scanner_y,obj_player.x,obj_player.y));
        playerdir_ver1 = degtorad(point_direction(scanner_y,scanner_z,obj_player.y,obj_player.z));
        playerdir_ver2 = degtorad(point_direction(scanner_x,scanner_z,obj_player.y,obj_player.z));
        }
    else
        {
        shader_set(normalshader);
        }
    
    switch (format)
        {
        case 4: //format 4: new 3d
            {
            list_size = (ds_list_size(list_id)-1);
            np_pos = 1;
            
            xpn = ds_list_find_value(list_id,np_pos)/$ffff*4096;
            ypn = ds_list_find_value(list_id,np_pos+1)/$ffff*4096;
            if (xpn >= 2048)
                xpn -= 2048;
            else
                xpn += 2048;
            if (ypn >= 2048)
                ypn -= 2048;
            else
                ypn += 2048;
            //ypn = 4096-ypn;
            ypn -= 2048;
            xpn -= 2048;
            //xpn = 1024-xpn;
            
            xpnpos = scanner_x+500*sin(pihalf-yrad-ypn/anglemult)*cos(pihalf-xrad-xpn/anglemult);
            ypnpos = scanner_y+500*sin(pihalf-yrad-ypn/anglemult)*sin(pihalf-xrad-xpn/anglemult);
            zpnpos = scanner_z+500*cos(pihalf-yrad-ypn/anglemult);
            
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
                xpn = ds_list_find_value(list_id,np_pos)/$ffff*4096;
                ypn = ds_list_find_value(list_id,np_pos+1)/$ffff*4096;
                //xpn = parse_word(xpn);
                //ypn = parse_word(ypn);
                if (xpn >= 2048)
                    xpn -= 2048;
                else
                    xpn += 2048;
                if (ypn >= 2048)
                    ypn -= 2048;
                else
                    ypn += 2048;
                //ypn = 4096-ypn;
                ypn -= 2048;
                xpn -= 2048;
                
                //xpn = 1024-xpn;
                xpnpos = scanner_x+500*sin(pihalf-yrad-ypn/anglemult)*cos(pihalf-xrad-xpn/anglemult);
                ypnpos = scanner_y+500*sin(pihalf-yrad-ypn/anglemult)*sin(pihalf-xrad-xpn/anglemult);
                zpnpos = scanner_z+500*cos(pihalf-yrad-ypn/anglemult);
                    
                //if blanking bit is on, draw line between the two points
                if !(blank)
                    {
                    blue = ds_list_find_value(list_id,np_pos+4);
                    green = ds_list_find_value(list_id,np_pos+5);
                    red = ds_list_find_value(list_id,np_pos+6);
                    colormade = make_color_rgb(red,green,blue);
                    
                    
                    if (controller.fog)
                        {
                        pointdir_hor = degtorad(point_direction(scanner_x,scanner_y,xppos,yppos));
                        pointdir_ver1 = degtorad(point_direction(scanner_y,scanner_z,yppos,zppos));
                        pointdir_ver2 = degtorad(point_direction(scanner_x,scanner_z,xppos,zppos));
                        usealpha = alpha-alpha*0.9*sqrt(sqrt(max(abs(sin(playerdir_hor-pointdir_hor)),abs(sin(playerdir_ver1-pointdir_ver1)),abs(sin(playerdir_ver2-pointdir_ver2)))));
                        }
                    
                    if ((xpn == xp) && (ypn == yp))
                        {
                        d3d_primitive_begin_texture(pr_linelist,background_get_texture(bck_smoke));
                            d3d_vertex_texture_colour(scanner_x,scanner_y,scanner_z,0,0,colormade,usealpha);
                            d3d_vertex_texture_colour(xppos,yppos,zppos,0,0,colormade,0);
                        d3d_primitive_end();
                        }
                    else
                        {
                        d3d_primitive_begin_texture(pr_trianglelist,background_get_texture(bck_smoke));
                            d3d_vertex_texture_colour(scanner_x,scanner_y,scanner_z,0,0,colormade,usealpha*1.5);
                            d3d_vertex_texture_colour(xppos,yppos,zppos,0,0,colormade,0);
                            d3d_vertex_texture_colour(xpnpos,ypnpos,zpnpos,0,0,colormade,0);
                        d3d_primitive_end();
                        }
                    }
                    
                if (dual)
                    {
                    xpnposdual = full_length-scanner_x+500*sin(pihalf-yrad-ypn/anglemult)*cos(-pihalf-xrad-xpn/anglemult);
                    xpposdual = full_length-scanner_x+500*sin(pihalf-yrad-yp/anglemult)*cos(-pihalf-xrad-xp/anglemult);
                        
                    //if blanking bit is on, draw line between the two points
                    if !(blank)
                        {
                        blue = ds_list_find_value(list_id,np_pos+4);
                        green = ds_list_find_value(list_id,np_pos+5);
                        red = ds_list_find_value(list_id,np_pos+6);
                        colormade = make_color_rgb(red,green,blue);
                        
                        if (controller.fog)
                            {
                            pointdir_hor = degtorad(point_direction(scanner_x,scanner_y,xpposdual,yppos));
                            pointdir_ver1 = degtorad(point_direction(scanner_y,scanner_z,yppos,zppos));
                            pointdir_ver2 = degtorad(point_direction(scanner_x,scanner_z,xpposdual,zppos));
                            usealpha = alpha-alpha*0.9*sqrt(sqrt(max(abs(sin(playerdir_hor-pointdir_hor)),abs(sin(playerdir_ver1-pointdir_ver1)),abs(sin(playerdir_ver2-pointdir_ver2)))));
                            }
                        
                        if ((xpn == xp) && (ypn == yp))
                            {
                            d3d_primitive_begin_texture(pr_linelist,background_get_texture(bck_smoke));
                                d3d_vertex_texture_color(full_length-scanner_x,scanner_y,scanner_z,0,0,colormade,usealpha);
                                d3d_vertex_texture_color(xpposdual,yppos,zppos,0,0,colormade,usealpha*0.3);
                            d3d_primitive_end();
                            }
                        else
                            {
                            d3d_primitive_begin_texture(pr_trianglelist,background_get_texture(bck_smoke));
                                d3d_vertex_texture_colour(full_length-scanner_x,scanner_y,scanner_z,0,0,colormade,usealpha*1.5);
                                d3d_vertex_texture_colour(xpposdual,yppos,zppos,0,0,colormade,0);
                                d3d_vertex_texture_colour(xpnposdual,ypnpos,zpnpos,0,0,colormade,0);
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
            
            xpn = ds_list_find_value(list_id,np_pos)/$ffff*4096;
            ypn = ds_list_find_value(list_id,np_pos+1)/$ffff*4096;
            if (xpn >= 2048)
                xpn -= 2048;
            else
                xpn += 2048;
            if (ypn >= 2048)
                ypn -= 2048;
            else
                ypn += 2048;
            //ypn = 4096-ypn;
            ypn -= 2048;
            xpn -= 2048;
            //xpn = 1024-xpn;
            
            xpnpos = scanner_x+500*sin(pihalf-yrad-ypn/anglemult)*cos(pihalf-xrad-xpn/anglemult);
            ypnpos = scanner_y+500*sin(pihalf-yrad-ypn/anglemult)*sin(pihalf-xrad-xpn/anglemult);
            zpnpos = scanner_z+500*cos(pihalf-yrad-ypn/anglemult);
            
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
                xpn = ds_list_find_value(list_id,np_pos)/$ffff*4096;
                ypn = ds_list_find_value(list_id,np_pos+1)/$ffff*4096;
                //xpn = parse_word(xpn);
                //ypn = parse_word(ypn);
                if (xpn >= 2048)
                    xpn -= 2048;
                else
                    xpn += 2048;
                if (ypn >= 2048)
                    ypn -= 2048;
                else
                    ypn += 2048;
                //ypn = 4096-ypn;
                ypn -= 2048;
                xpn -= 2048;
                
                //xpn = 1024-xpn;
                xpnpos = scanner_x+500*sin(pihalf-yrad-ypn/anglemult)*cos(pihalf-xrad-xpn/anglemult);
                ypnpos = scanner_y+500*sin(pihalf-yrad-ypn/anglemult)*sin(pihalf-xrad-xpn/anglemult);
                zpnpos = scanner_z+500*cos(pihalf-yrad-ypn/anglemult);
                    
                //if blanking bit is on, draw line between the two points
                if !(blank)
                    {
                    blue = ds_list_find_value(list_id,np_pos+3);
                    green = ds_list_find_value(list_id,np_pos+4);
                    red = ds_list_find_value(list_id,np_pos+5);
                    colormade = make_color_rgb(red,green,blue);
                    
                    if (controller.fog)
                        {
                        pointdir_hor = degtorad(point_direction(scanner_x,scanner_y,xppos,yppos));
                        pointdir_ver1 = degtorad(point_direction(scanner_y,scanner_z,yppos,zppos));
                        pointdir_ver2 = degtorad(point_direction(scanner_x,scanner_z,xppos,zppos));
                        usealpha = alpha-alpha*0.9*sqrt(sqrt(max(abs(sin(playerdir_hor-pointdir_hor)),abs(sin(playerdir_ver1-pointdir_ver1)),abs(sin(playerdir_ver2-pointdir_ver2)))));
                        //show_debug_message(usealpha)
                        }
                    
                    if ((xpn == xp) && (ypn == yp))
                        {
                        d3d_primitive_begin_texture(pr_linelist,background_get_texture(bck_smoke));
                            d3d_vertex_texture_colour(scanner_x,scanner_y,scanner_z,0,0,colormade,usealpha);
                            d3d_vertex_texture_colour(xppos,yppos,zppos,0,0,colormade,0);
                        d3d_primitive_end();
                        }
                    else
                        {
                        d3d_primitive_begin_texture(pr_trianglelist,background_get_texture(bck_smoke));
                            d3d_vertex_texture_color(scanner_x,scanner_y,scanner_z,0,0,colormade,usealpha*1.5);
                            d3d_vertex_texture_color(xppos,yppos,zppos,0,0,colormade,usealpha*0.3);
                            d3d_vertex_texture_color(xpnpos,ypnpos,zpnpos,0,0,colormade,usealpha*0.3);
                        d3d_primitive_end();
                        }
                    }
                    
                if (dual)
                    {
                    xpnposdual = full_length-scanner_x+500*sin(pihalf-yrad-ypn/anglemult)*cos(-pihalf-xrad-xpn/anglemult);
                    xpposdual = full_length-scanner_x+500*sin(pihalf-yrad-yp/anglemult)*cos(-pihalf-xrad-xp/anglemult);
                        
                    //if blanking bit is on, draw line between the two points
                    if !(blank)
                        {
                        blue = ds_list_find_value(list_id,np_pos+3);
                        green = ds_list_find_value(list_id,np_pos+4);
                        red = ds_list_find_value(list_id,np_pos+5);
                        colormade = make_color_rgb(red,green,blue);
                        
                        if (controller.fog)
                            {
                            pointdir_hor = degtorad(point_direction(scanner_x,scanner_y,xpposdual,yppos));
                            pointdir_ver1 = degtorad(point_direction(scanner_y,scanner_z,yppos,zppos));
                            pointdir_ver2 = degtorad(point_direction(scanner_x,scanner_z,xpposdual,zppos));
                            usealpha = alpha-alpha*0.9*sqrt(sqrt(max(abs(sin(playerdir_hor-pointdir_hor)),abs(sin(playerdir_ver1-pointdir_ver1)),abs(sin(playerdir_ver2-pointdir_ver2)))));
                            }
                        
                        if ((xpn == xp) && (ypn == yp))
                            {
                            d3d_primitive_begin_texture(pr_linelist,background_get_texture(bck_smoke));
                                d3d_vertex_texture_color(full_length-scanner_x,scanner_y,scanner_z,0,0,colormade,usealpha);
                                d3d_vertex_texture_color(xpposdual,yppos,zppos,0,0,colormade,usealpha*0.3);
                            d3d_primitive_end();
                            }
                        else
                            {
                            d3d_primitive_begin_texture(pr_trianglelist,background_get_texture(bck_smoke));
                                d3d_vertex_texture_color(full_length-scanner_x,scanner_y,scanner_z,0,0,colormade,usealpha*1.5);
                                d3d_vertex_texture_color(xpposdual,yppos,zppos,0,0,colormade,usealpha*0.3);
                                d3d_vertex_texture_color(xpnposdual,ypnpos,zpnpos,0,0,colormade,usealpha*0.3);
                            d3d_primitive_end();
                            }
                        }
                    }
                np_pos+=6;
                }
            break;
            }
        }
        
    draw_set_blend_mode(bm_normal);
    shader_reset();
    }
