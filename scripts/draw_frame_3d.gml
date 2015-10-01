//draws the laser projecton for all the scanners
draw_set_color(c_white);
draw_enable_alphablend(1);
draw_set_blend_mode(bm_add);
d3d_set_culling(0);
d3d_set_lighting(0);
d3d_set_hidden(0);
full_length = 8;

if (controller.frameprev != controller.frame)
    {
    half_length = full_length/2;
    pihalf = pi/2;
    
    controller.frameprev = controller.frame;
    for (i = 0; i < ds_list_size(controller.draw_list); i++)
        {
        ds_list_destroy(ds_list_find_value(controller.draw_list,i));
        }
    ds_list_clear(controller.draw_list);
    
    for (i = 0; i < ds_list_size(controller.scan_list); i++)
        {
        ild_list = ds_list_find_value(controller.scan_list,i);
        list_id = ds_list_find_value(ild_list,10+controller.frame);
    
        if (ds_list_size(list_id) < 2)
            continue;
            
        format = ds_list_find_value(ild_list,9);
        scanner_x = ds_list_find_value(ild_list,1)/600*full_length;
        scanner_z = ds_list_find_value(ild_list,7)/600*full_length+half_length/2;
        scanner_y = ds_list_find_value(ild_list,2)/600*full_length;
        xrad = ds_list_find_value(ild_list,3);
        yrad = ds_list_find_value(ild_list,4);
        angle = ds_list_find_value(ild_list,6);
        alpha = ds_list_find_value(ild_list,5)*0.3;
        dual = ds_list_find_value(ild_list,0);
        
        tempframe_list = ds_list_create();
        ds_list_add(controller.draw_list, tempframe_list);
        
        ds_list_add(tempframe_list,dual);
        ds_list_add(tempframe_list,scanner_x);
        ds_list_add(tempframe_list,scanner_y);
        ds_list_add(tempframe_list,xrad);
        ds_list_add(tempframe_list,yrad);
        ds_list_add(tempframe_list,alpha);
        ds_list_add(tempframe_list,angle);
        ds_list_add(tempframe_list,scanner_z);
        ds_list_add(tempframe_list,0);
        ds_list_add(tempframe_list,format);
        
        anglemult = 10*angle;
        
        list_size = (ds_list_size(list_id)-1);
        np_pos = 1;
        
        xpn = ds_list_find_value(list_id,np_pos)/$ffff*full_length;
        ypn = ds_list_find_value(list_id,np_pos+1)/$ffff*full_length;
        if (xpn >= half_length)
            xpn -= full_length;
        if (ypn >= half_length)
            ypn -= full_length;
        
        trigopy = pihalf-yrad-ypn/anglemult;
        trigopx = pihalf-xrad-xpn/anglemult;
        sinycalc = sin(trigopy);
        cosxcalc = cos(trigopx);
        xpnpos = scanner_x+25*sinycalc*cosxcalc;
        zpnpos = scanner_y+25*sinycalc*sin(trigopx);
        ypnpos = scanner_z+25*cos(trigopy);
        
        np_pos = 5;
            
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
            if (xpn >= half_length)
                xpn -= full_length;
            if (ypn >= half_length)
                ypn -= full_length;
            
            trigopy = pihalf-yrad-ypn/anglemult;
            trigopx = pihalf-xrad-xpn/anglemult;
            sinycalc = sin(trigopy);
            cosxcalc = cos(trigopx);
            xpnpos = scanner_x+25*sinycalc*cosxcalc;
            zpnpos = scanner_y+25*sinycalc*sin(trigopx);
            ypnpos = scanner_z+25*cos(trigopy);
                
            //if blanking bit is off, draw primitive
            if !(blank)
                {
                if (controller.fog) and (dual)
                    {
                    scanner_pos[0] = scanner_x;
                    shader_set_uniform_f_array(controller.u1_scanner_pos,scanner_pos);
                    }
                colormade = ds_list_find_value(list_id,np_pos+3);
                
                if ((xpn == xp) && (ypn == yp))
                    {
                    ds_list_add(tempframe_list, 1);
                    }
                else
                    {
                    ds_list_add(tempframe_list, 0);
                    }
                ds_list_add(tempframe_list, colormade);
                ds_list_add(tempframe_list, xppos);
                ds_list_add(tempframe_list, yppos);
                ds_list_add(tempframe_list, zppos);
                ds_list_add(tempframe_list, xpnpos);
                ds_list_add(tempframe_list, ypnpos);
                ds_list_add(tempframe_list, zpnpos);
                ds_list_add(tempframe_list, scanner_x);
                }
                
            if (dual)
                {
                flminussx = full_length-scanner_x;
                trigopx -= pi;
                cosxcalc = cos(trigopx);
                xpnposdual = flminussx+25*sinycalc*cosxcalc;
                xpposdual = flminussx+25*sin(pihalf-yrad-yp/anglemult)*cos(-pihalf-xrad-xp/anglemult);
                
                //if blanking bit is on, draw primitive
                if !(blank)
                    {
                    if (controller.fog) 
                        {
                        scanner_pos[0] = flminussx;
                        shader_set_uniform_f_array(controller.u1_scanner_pos,scanner_pos);
                        }
                    colormade = ds_list_find_value(list_id,np_pos+3);
                    
                    if ((xpn == xp) && (ypn == yp))
                        {
                        ds_list_add(tempframe_list, 1);
                        }
                    else
                        {
                        ds_list_add(tempframe_list, 0);
                        }
                    ds_list_add(tempframe_list, colormade);
                    ds_list_add(tempframe_list, xpposdual);
                    ds_list_add(tempframe_list, yppos);
                    ds_list_add(tempframe_list, zppos);
                    ds_list_add(tempframe_list, xpnposdual);
                    ds_list_add(tempframe_list, ypnpos);
                    ds_list_add(tempframe_list, zpnpos);
                    ds_list_add(tempframe_list, flminussx);
                    }
                }
            np_pos+=4;
            }
        }
    }

for (i = 0; i < ds_list_size(controller.draw_list); i++)
    {
    tempframe_list = ds_list_find_value(controller.draw_list,i);

    if (ds_list_size(tempframe_list) < 12)
        continue;
        
    format = ds_list_find_value(tempframe_list,9);
    scanner_x = ds_list_find_value(tempframe_list,1);
    scanner_z = ds_list_find_value(tempframe_list,7);
    scanner_y = ds_list_find_value(tempframe_list,2);
    xrad = ds_list_find_value(tempframe_list,3);
    yrad = ds_list_find_value(tempframe_list,4);
    angle = ds_list_find_value(tempframe_list,6);
    alpha = ds_list_find_value(tempframe_list,5);
    dual = ds_list_find_value(tempframe_list,0);
    
    if (controller.fog == 1) 
        {
        shader_set(lasershader);
        usealpha = alpha;
        shader_set_uniform_f(controller.u_time,controller.time);
        scanner_pos[0] = scanner_x;
        scanner_pos[1] = scanner_y;
        scanner_pos[2] = scanner_z//-half_length/2;
        shader_set_uniform_f_array(controller.u1_scanner_pos,scanner_pos);
        player_pos[0] = obj_player.X;
        player_pos[1] = obj_player.Y;
        player_pos[2] = obj_player.Z;
        shader_set_uniform_f_array(controller.u1_player_pos,player_pos);
        }
    else if (controller.fog == 2) 
        {
        shader_set(lasershader_nonoise);
        usealpha = alpha;
        scanner_pos[0] = scanner_x;
        scanner_pos[1] = scanner_y;
        scanner_pos[2] = scanner_z//-half_length/2;
        shader_set_uniform_f_array(controller.u2_scanner_pos,scanner_pos);
        player_pos[0] = obj_player.X;
        player_pos[1] = obj_player.Y;
        player_pos[2] = obj_player.Z;
        shader_set_uniform_f_array(controller.u2_player_pos,player_pos);
        }
    else
        {
        shader_set(normalshader);
        usealpha = alpha;
        scanner_pos[0] = scanner_x;
        scanner_pos[1] = scanner_y;
        scanner_pos[2] = scanner_z//-half_length/2;
        shader_set_uniform_f_array(controller.u3_scanner_pos,scanner_pos);
        player_pos[0] = obj_player.X;
        player_pos[1] = obj_player.Y;
        player_pos[2] = obj_player.Z;
        shader_set_uniform_f_array(controller.u3_player_pos,player_pos);
        }
    
    usealpha50p = usealpha*1.5;
    
    for (u = 10; u < ds_list_size(tempframe_list); u+= 9)
        {
        if (controller.fog) and (dual)
            {
            scanner_pos[0] = ds_list_find_value(tempframe_list,u+8);
            shader_set_uniform_f_array(controller.u1_scanner_pos,scanner_pos);
            }
            
        if (ds_list_find_value(tempframe_list,u))
            {
            draw_set_colour(ds_list_find_value(tempframe_list,u+1));
            draw_set_alpha(usealpha50p);
            d3d_primitive_begin_texture(pr_linelist,background_get_texture(bck_smoke));
                d3d_vertex_texture( ds_list_find_value(tempframe_list,u+8),scanner_y,scanner_z,0,0);
                d3d_vertex_texture( ds_list_find_value(tempframe_list,u+2),
                                    ds_list_find_value(tempframe_list,u+3),
                                    ds_list_find_value(tempframe_list,u+4),0,0);
            d3d_primitive_end();
            }
        else
            {
            draw_set_colour(ds_list_find_value(tempframe_list,u+1));
            draw_set_alpha(usealpha);
            d3d_primitive_begin_texture(pr_trianglelist,background_get_texture(bck_smoke));
                d3d_vertex_texture( ds_list_find_value(tempframe_list,u+8),scanner_y,scanner_z,0,0);
                d3d_vertex_texture( ds_list_find_value(tempframe_list,u+2),
                                    ds_list_find_value(tempframe_list,u+3),
                                    ds_list_find_value(tempframe_list,u+4),0,0);
                d3d_vertex_texture( ds_list_find_value(tempframe_list,u+5),
                                    ds_list_find_value(tempframe_list,u+6),
                                    ds_list_find_value(tempframe_list,u+7),0,0);
            d3d_primitive_end();
            }
        }
    shader_reset();
    }

draw_set_blend_mode(bm_normal);
draw_set_alpha(1);
draw_set_colour(c_white);
