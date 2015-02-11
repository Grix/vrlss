if (!ds_list_size(controller.scan_list))
    exit;
    
exportfname = get_save_filename("*.vri","show.vri");

exbuf = buffer_create(1000,buffer_grow,1);