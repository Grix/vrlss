//draws the laser projecton for all the scanners


for (i = 0;i <= (ds_list_size(controller.scan_list)-1);i++)
    {
    ild_list = ds_list_find_value(controller.scan_list,i);
    list_id = ds_list_find_value(ild_list,10+controller.frame);
    format = ds_list_find_value(ild_list,9);
    scanner_x = ds_list_find_value(ild_list,1);
    scanner_y = 0;
    scanner_z = ds_list_find_value(ild_list,2);;
    xrad = ds_list_find_value(ild_list,3);
    yrad = ds_list_find_value(ild_list,4);
    angle = ds_list_find_value(ild_list,6);
    alpha = ds_list_find_value(ild_list,5);
    dual = ds_list_find_value(ild_list,0);
    pihalf = pi/2;
    anglemult = 4096*angle;
    
    draw_set_color(c_white);
    draw_set_alpha(1);
    usealpha = alpha*0.8;
    draw_set_blend_mode_ext(bm_src_alpha,bm_dest_alpha);
    d3d_set_culling(false);
    if (controller.fog) 
        {
        shader_set(lasershader);
        usealpha /= 0.5;
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
            
            xpnpos = scanner_x+2000*sin(pihalf-yrad-ypn/anglemult)*cos(pihalf-xrad-xpn/anglemult);
            ypnpos = scanner_y+2000*sin(pihalf-yrad-ypn/anglemult)*sin(pihalf-xrad-xpn/anglemult);
            zpnpos = scanner_z+2000*cos(pihalf-yrad-ypn/anglemult);
            
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
                xpnpos = scanner_x+2000*sin(pihalf-yrad-ypn/anglemult)*cos(pihalf-xrad-xpn/anglemult);
                ypnpos = scanner_y+2000*sin(pihalf-yrad-ypn/anglemult)*sin(pihalf-xrad-xpn/anglemult);
                zpnpos = scanner_z+2000*cos(pihalf-yrad-ypn/anglemult);
                    
                //if blanking bit is on, draw line between the two points
                if !(blank)
                    {
                    blue = ds_list_find_value(list_id,np_pos+4);
                    green = ds_list_find_value(list_id,np_pos+5);
                    red = ds_list_find_value(list_id,np_pos+6);
                    colormade = make_color_rgb(red,green,blue);
                    
                    if ((xpn == xp) && (ypn == yp))
                        {
                        d3d_primitive_begin_texture(pr_trianglelist,background_get_texture(bck_smoke));
                            d3d_vertex_texture_color(scanner_x,scanner_y,scanner_z,0,0,colormade,usealpha*1.5);
                            d3d_vertex_texture_color(xppos-3,yppos-3,zppos,0,0,colormade,usealpha*0.2);
                            d3d_vertex_texture_color(xpnpos+3,ypnpos-3,zpnpos,0,0,colormade,usealpha*0.2);
                        d3d_primitive_end();
                        d3d_primitive_begin_texture(pr_trianglelist,background_get_texture(bck_smoke));
                            d3d_vertex_texture_color(scanner_x,scanner_y,scanner_z,0,0,colormade,usealpha*1.5);
                            d3d_vertex_texture_color(xppos+3,yppos-3,zppos,0,0,colormade,usealpha*0.2);
                            d3d_vertex_texture_color(xpnpos+3,ypnpos+3,zpnpos,0,0,colormade,usealpha*0.2);
                        d3d_primitive_end();
                        d3d_primitive_begin_texture(pr_trianglelist,background_get_texture(bck_smoke));
                            d3d_vertex_texture_color(scanner_x,scanner_y,scanner_z,0,0,colormade,usealpha*1.5);
                            d3d_vertex_texture_color(xppos+3,yppos+3,zppos,0,0,colormade,usealpha*0.2);
                            d3d_vertex_texture_color(xpnpos-3,ypnpos+3,zpnpos,0,0,colormade,usealpha*0.2);
                        d3d_primitive_end();
                        d3d_primitive_begin_texture(pr_trianglelist,background_get_texture(bck_smoke));
                            d3d_vertex_texture_color(scanner_x,scanner_y,scanner_z,0,0,colormade,usealpha*1.5);
                            d3d_vertex_texture_color(xppos-3,yppos+3,zppos,0,0,colormade,usealpha*0.2);
                            d3d_vertex_texture_color(xpnpos-3,ypnpos-3,zpnpos,0,0,colormade,usealpha*0.2);
                        d3d_primitive_end();
                        }
                    else
                        {
                        d3d_primitive_begin_texture(pr_trianglelist,background_get_texture(bck_smoke));
                            d3d_vertex_texture_color(scanner_x,scanner_y,scanner_z,0,0,colormade,usealpha);
                            d3d_vertex_texture_color(xppos,yppos,zppos,0,0,colormade,usealpha*0.2);
                            d3d_vertex_texture_color(xpnpos,ypnpos,zpnpos,0,0,colormade,usealpha*0.2);
                        d3d_primitive_end();
                        }
                    }
                    
                if (dual)
                    {
                    xpnposdual = 600-scanner_x+2000*sin(pihalf-yrad-ypn/anglemult)*cos(-pihalf-xrad-xpn/anglemult);
                    xpposdual = 600-scanner_x+2000*sin(pihalf-yrad-yp/anglemult)*cos(-pihalf-xrad-xp/anglemult);
                        
                    //if blanking bit is on, draw line between the two points
                    if !(blank)
                        {
                        blue = ds_list_find_value(list_id,np_pos+4);
                        green = ds_list_find_value(list_id,np_pos+5);
                        red = ds_list_find_value(list_id,np_pos+6);
                        colormade = make_color_rgb(red,green,blue);
                        
                        if ((xpn == xp) && (ypn == yp))
                            {
                            d3d_primitive_begin_texture(pr_trianglelist,background_get_texture(bck_smoke));
                                d3d_vertex_texture_color(600-scanner_x,scanner_y,scanner_z,0,0,colormade,usealpha*1.5);
                                d3d_vertex_texture_color(xpposdual-3,yppos-3,zppos,0,0,colormade,usealpha*0.2);
                                d3d_vertex_texture_color(xpnposdual+3,ypnpos-3,zpnpos,0,0,colormade,usealpha*0.2);
                            d3d_primitive_end();
                            d3d_primitive_begin_texture(pr_trianglelist,background_get_texture(bck_smoke));
                                d3d_vertex_texture_color(600-scanner_x,scanner_y,scanner_z,0,0,colormade,usealpha*1.5);
                                d3d_vertex_texture_color(xpposdual+3,yppos-3,zppos,0,0,colormade,usealpha*0.2);
                                d3d_vertex_texture_color(xpnposdual+3,ypnpos+3,zpnpos,0,0,colormade,usealpha*0.2);
                            d3d_primitive_end();
                            d3d_primitive_begin_texture(pr_trianglelist,background_get_texture(bck_smoke));
                                d3d_vertex_texture_color(600-scanner_x,scanner_y,scanner_z,0,0,colormade,usealpha*1.5);
                                d3d_vertex_texture_color(xpposdual+3,yppos+3,zppos,0,0,colormade,usealpha*0.2);
                                d3d_vertex_texture_color(xpnposdual-3,ypnpos+3,zpnpos,0,0,colormade,usealpha*0.2);
                            d3d_primitive_end();
                            d3d_primitive_begin_texture(pr_trianglelist,background_get_texture(bck_smoke));
                                d3d_vertex_texture_color(600-scanner_x,scanner_y,scanner_z,0,0,colormade,usealpha*1.5);
                                d3d_vertex_texture_color(xpposdual-3,yppos+3,zppos,0,0,colormade,usealpha*0.2);
                                d3d_vertex_texture_color(xpnposdual-3,ypnpos-3,zpnpos,0,0,colormade,usealpha*0.2);
                            d3d_primitive_end();
                            }
                        else
                            {
                            d3d_primitive_begin_texture(pr_trianglelist,background_get_texture(bck_smoke));
                                d3d_vertex_texture_color(600-scanner_x,scanner_y,scanner_z,0,0,colormade,usealpha);
                                d3d_vertex_texture_color(xpposdual,yppos,zppos,0,0,colormade,usealpha*0.2);
                                d3d_vertex_texture_color(xpnposdual,ypnpos,zpnpos,0,0,colormade,usealpha*0.2);
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
            
            xpnpos = scanner_x+2000*sin(pihalf-yrad-ypn/anglemult)*cos(pihalf-xrad-xpn/anglemult);
            ypnpos = scanner_y+2000*sin(pihalf-yrad-ypn/anglemult)*sin(pihalf-xrad-xpn/anglemult);
            zpnpos = scanner_z+2000*cos(pihalf-yrad-ypn/anglemult);
            
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
                xpnpos = scanner_x+2000*sin(pihalf-yrad-ypn/anglemult)*cos(pihalf-xrad-xpn/anglemult);
                ypnpos = scanner_y+2000*sin(pihalf-yrad-ypn/anglemult)*sin(pihalf-xrad-xpn/anglemult);
                zpnpos = scanner_z+2000*cos(pihalf-yrad-ypn/anglemult);
                    
                //if blanking bit is on, draw line between the two points
                if !(blank)
                    {
                    blue = ds_list_find_value(list_id,np_pos+3);
                    green = ds_list_find_value(list_id,np_pos+4);
                    red = ds_list_find_value(list_id,np_pos+5);
                    colormade = make_color_rgb(red,green,blue);
                    
                    if ((xpn == xp) && (ypn == yp))
                        {
                        d3d_primitive_begin_texture(pr_trianglelist,background_get_texture(bck_smoke));
                            d3d_vertex_texture_color(scanner_x,scanner_y,scanner_z,0,0,colormade,usealpha*1.5);
                            d3d_vertex_texture_color(xppos-3,yppos-3,zppos,0,0,colormade,usealpha*0.2);
                            d3d_vertex_texture_color(xpnpos+3,ypnpos-3,zpnpos,0,0,colormade,usealpha*0.2);
                        d3d_primitive_end();
                        d3d_primitive_begin_texture(pr_trianglelist,background_get_texture(bck_smoke));
                            d3d_vertex_texture_color(scanner_x,scanner_y,scanner_z,0,0,colormade,usealpha*1.5);
                            d3d_vertex_texture_color(xppos+3,yppos-3,zppos,0,0,colormade,usealpha*0.2);
                            d3d_vertex_texture_color(xpnpos+3,ypnpos+3,zpnpos,0,0,colormade,usealpha*0.2);
                        d3d_primitive_end();
                        d3d_primitive_begin_texture(pr_trianglelist,background_get_texture(bck_smoke));
                            d3d_vertex_texture_color(scanner_x,scanner_y,scanner_z,0,0,colormade,usealpha*1.5);
                            d3d_vertex_texture_color(xppos+3,yppos+3,zppos,0,0,colormade,usealpha*0.2);
                            d3d_vertex_texture_color(xpnpos-3,ypnpos+3,zpnpos,0,0,colormade,usealpha*0.2);
                        d3d_primitive_end();
                        d3d_primitive_begin_texture(pr_trianglelist,background_get_texture(bck_smoke));
                            d3d_vertex_texture_color(scanner_x,scanner_y,scanner_z,0,0,colormade,usealpha*1.5);
                            d3d_vertex_texture_color(xppos-3,yppos+3,zppos,0,0,colormade,usealpha*0.2);
                            d3d_vertex_texture_color(xpnpos-3,ypnpos-3,zpnpos,0,0,colormade,usealpha*0.2);
                        d3d_primitive_end();
                        }
                    else
                        {
                        d3d_primitive_begin_texture(pr_trianglelist,background_get_texture(bck_smoke));
                            d3d_vertex_texture_color(scanner_x,scanner_y,scanner_z,0,0,colormade,usealpha);
                            d3d_vertex_texture_color(xppos,yppos,zppos,0,0,colormade,usealpha*0.2);
                            d3d_vertex_texture_color(xpnpos,ypnpos,zpnpos,0,0,colormade,usealpha*0.2);
                        d3d_primitive_end();
                        }
                    }
                    
                if (dual)
                    {
                    xpnposdual = 600-scanner_x+2000*sin(pihalf-yrad-ypn/anglemult)*cos(-pihalf-xrad-xpn/anglemult);
                    xpposdual = 600-scanner_x+2000*sin(pihalf-yrad-yp/anglemult)*cos(-pihalf-xrad-xp/anglemult);
                        
                    //if blanking bit is on, draw line between the two points
                    if !(blank)
                        {
                        blue = ds_list_find_value(list_id,np_pos+3);
                        green = ds_list_find_value(list_id,np_pos+4);
                        red = ds_list_find_value(list_id,np_pos+5);
                        colormade = make_color_rgb(red,green,blue);
                        
                        if ((xpn == xp) && (ypn == yp))
                            {
                            d3d_primitive_begin_texture(pr_trianglelist,background_get_texture(bck_smoke));
                                d3d_vertex_texture_color(600-scanner_x,scanner_y,scanner_z,0,0,colormade,usealpha*1.5);
                                d3d_vertex_texture_color(xpposdual-3,yppos-3,zppos,0,0,colormade,usealpha*0.2);
                                d3d_vertex_texture_color(xpnposdual+3,ypnpos-3,zpnpos,0,0,colormade,usealpha*0.2);
                            d3d_primitive_end();
                            d3d_primitive_begin_texture(pr_trianglelist,background_get_texture(bck_smoke));
                                d3d_vertex_texture_color(600-scanner_x,scanner_y,scanner_z,0,0,colormade,usealpha*1.5);
                                d3d_vertex_texture_color(xpposdual+3,yppos-3,zppos,0,0,colormade,usealpha*0.2);
                                d3d_vertex_texture_color(xpnposdual+3,ypnpos+3,zpnpos,0,0,colormade,usealpha*0.2);
                            d3d_primitive_end();
                            d3d_primitive_begin_texture(pr_trianglelist,background_get_texture(bck_smoke));
                                d3d_vertex_texture_color(600-scanner_x,scanner_y,scanner_z,0,0,colormade,usealpha*1.5);
                                d3d_vertex_texture_color(xpposdual+3,yppos+3,zppos,0,0,colormade,usealpha*0.2);
                                d3d_vertex_texture_color(xpnposdual-3,ypnpos+3,zpnpos,0,0,colormade,usealpha*0.2);
                            d3d_primitive_end();
                            d3d_primitive_begin_texture(pr_trianglelist,background_get_texture(bck_smoke));
                                d3d_vertex_texture_color(600-scanner_x,scanner_y,scanner_z,0,0,colormade,usealpha*1.5);
                                d3d_vertex_texture_color(xpposdual-3,yppos+3,zppos,0,0,colormade,usealpha*0.2);
                                d3d_vertex_texture_color(xpnposdual-3,ypnpos-3,zpnpos,0,0,colormade,usealpha*0.2);
                            d3d_primitive_end();
                            }
                        else
                            {
                            d3d_primitive_begin_texture(pr_trianglelist,background_get_texture(bck_smoke));
                                d3d_vertex_texture_color(600-scanner_x,scanner_y,scanner_z,0,0,colormade,usealpha);
                                d3d_vertex_texture_color(xpposdual,yppos,zppos,0,0,colormade,usealpha*0.2);
                                d3d_vertex_texture_color(xpnposdual,ypnpos,zpnpos,0,0,colormade,usealpha*0.2);
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
