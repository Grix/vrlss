draw_set_font(fnt_info);
if (rdy)
    {
    draw_set_halign(fa_left);
    draw_set_font(fnt_info);
    ild_list = ds_list_find_value(scan_list,0);
    list_id = ds_list_find_value(ild_list,frame+10);
    if (room == rm_3d)
        {
        }
    else if (room == rm_2d)
        {
        draw_set_color(c_white);
        draw_sprite(spr_audio,!songloaded,830,obj_audiobutton.y);
        
        draw_set_color(c_dkgray);
        draw_line(513,10,513,502);
        
        draw_set_color(c_aqua);
        draw_text(5,5,tooltip);
        draw_set_color(c_ltgray);
        
        tooltip = "";
        
        draw_text(630,30,"Press 'Help' for controls and manual!"+
                                "##Frame number "+string(frame)+"/"+string(ds_list_size(ild_list)-11)+
                                "#Time: "+ms2time(frame)+" / "+ms2time(ds_list_size(ild_list)-11)+
                                "##FPS: " + string(fps));
        if (!ildaloaded)
            draw_text(630,150,"No ilda file loaded");
        else
            draw_text(630,150,"ILDA scanner number: "+string( ds_list_find_value(ds_list_find_value(scan_list,selected_scanner),8) )+
                                    "#ILDA format: "+string( ds_list_find_value(ds_list_find_value(scan_list,selected_scanner),9) )+
                                    "#Number of frames: "+string( ds_list_size(ds_list_find_value(scan_list,selected_scanner))-10 ));
               
              
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

draw_set_halign(fa_left);
draw_set_font(fnt_info);
