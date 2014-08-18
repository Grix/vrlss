//works its way through an ilda file, finishes early so that a frame 
//can be drawn with the progress information

while (1)
    {
    action = read_ilda_header();
    if (action == 1)
        {
        rdy = 1;
        ildaloaded = 1;
        selected_scanner = ds_list_find_index(scan_list,ild_list);
        buffer_delete(ild_file);
        instance_activate_all();
        exit;
        }
    //if (action == 0)
    //    {

    //    }
    read_ilda_frame();
    if (action == 2)
        {
        alarm[2] = 1;
        exit;
        }
    }
