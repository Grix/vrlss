draw_set_font(fnt_info);
if (rdy)
    {
    draw_set_halign(fa_left);
    draw_set_font(fnt_info);
    //list_id = frame_list;
    ild_list = ds_list_find_value(scan_list,0);
    list_id = ds_list_find_value(ild_list,frame+10);
    if (room == rm_3d)
        {
        /// Draw some debugging text
        //draw_set_color(c_gray)
        /*if (GMO_getCameraMode() == 1)
            {
            draw_text_stroke(10,10,"Read the readme for controls and manual!"+
             "##Frame number "+string(frame)+"/"+string(ds_list_size(ild_list)-11)+
             "#Time: "+time(frame)+" / "+time(ds_list_size(ild_list)-11)+
             "##FPS: " + string(fps) +
             //"#Resolution: " + string(GMO_getResolutionWidth()) + "x" + string(GMO_getResolutionHeight()) +
             "#XY: " + string(obj_camera.x) + "x" + string(obj_camera.y) +
             "#Yaw/pitch" + string(obj_player.direction)+ "/"+string(obj_player.pitch)+
             "#Interpupillary Distance: " + string(GMO_getIPD()*global._GC_Ratio*10)+" mm");
             
             /*if (fpswarning) 
                {
                draw_set_color(c_red);
                //draw_set_font(fnt_parsing);
                draw_text(10,220,"Warning:#FPS has dropped lower than 75,#this can cause playback skipping");
                //draw_set_font(fnt_info);
                draw_set_color(c_ltgray);
                }
             }*/
        }
    else if (room == rm_2d)
        {
        draw_set_color(c_white);
        draw_sprite(spr_audio,!songloaded,830,477);
        
        draw_set_color(c_dkgray);
        draw_line(602,15,602,585);
        
        draw_set_color(c_aqua);
        draw_text(5,5,tooltip);
        draw_set_color(c_ltgray);
        
        tooltip = "";
        
        if (!ildaloaded)
            {
            draw_text_stroke(630,30,"Read the readme for controls and manual!"+
            "##No ilda file loaded");
            }
        else if (rdy == 1)
            {
            draw_text_stroke(630,30,"Read the readme for controls and manual!"+
            "##Frame number "+string(frame)+"/"+string(ds_list_size(ild_list)-11)+
            "#Time: "+time(frame)+" / "+time(ds_list_size(ild_list)-11)+
            "##FPS: " + string(fps));
            }
        else if (rdy > 1)
            {
            draw_text_stroke(630,30,"Read the readme for controls and manual!"+
            "##ILDA scanner number: "+string( ds_list_find_value(ds_list_find_value(scan_list,selected_scanner),8) )+
            "#ILDA format: "+string( ds_list_find_value(ds_list_find_value(scan_list,selected_scanner),9) )+
            "#Number of frames: "+string( ds_list_size(ds_list_find_value(scan_list,selected_scanner))-10 ));
            }         
              
        /*draw_set_font(fnt_parsing);       
            if (!global._GMO_DLL_LOADED) 
                {
                draw_set_color(c_red);
                draw_text(630,220,"Warning:#Oculus Rift Not Enabled");
                }
            else
                {
                switch (initDevice) 
                    {
                    case 0:
                        draw_set_color(c_red);
                        draw_text(635,150,"Warning:#Oculus Rift not found");
                        break;
                    case 1:
                        draw_set_color(c_green);
                        draw_text(635,150,"Oculus Rift working");
                        break;
                    case 2:
                        draw_set_color(c_yellow);
                        draw_text(635,150,"Warning:#Oculus Rift found#but display disabled");
                        break;
                    }
                }*/
        draw_set_font(fnt_info);
        draw_set_color(c_ltgray); 
        }
    }
else
    {
    if (file_size > 0)
        {
        draw_set_color(c_ltgray);
        draw_set_font(fnt_parsing);
        draw_text(20,20,"Parsing file: "+string(floor(i/1028))+"/"+string(floor(file_size/1028))+" kB, "+string(floor(i/file_size*100))+"%, frame number "+string(frame_number));
        }
    }
