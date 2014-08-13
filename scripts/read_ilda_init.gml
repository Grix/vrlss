
//initializes parsing of an ilda file, stores each frame in its own ds_list, a catalog of frames is kept in another ds_list
//arg0 is scanner number

filename = get_open_filename_ext("*.ild","*",working_directory,"Select ILDA file")
if (filename != "")
    {
    ild_file = file_bin_open(filename,0);
    file_size = file_bin_size(ild_file);
    file_bin_close(ild_file);
    ild_file = buffer_create(file_size,buffer_fast,1);
    buffer_load_ext(ild_file,filename,0);
    }
else
    return 0;
    

rdy = 0;

alarm[1]=1;

frame = 0;
play = 0;
progress = 0;
filename = "";
saud_stop(audio);

    i = 0;
    format = 0;
    name = "";
    author = "";

    ild_list = ds_list_create();
    

//read_ilda_header()
//read_ilda_frame()

for (i = 0;i <= (file_size-33);i++)
    {
    buffer_seek(ild_file,1,i);
    if (buffer_read(ild_file,buffer_u8) == $49)
        if (buffer_read(ild_file,buffer_u8) == $4C)
            if (buffer_read(ild_file,buffer_u8) == $44)
                if (buffer_read(ild_file,buffer_u8) == $41)
                    if (buffer_read(ild_file,buffer_u8) == $0)
                        if (buffer_read(ild_file,buffer_u8) == $0)
                            if (buffer_read(ild_file,buffer_u8) == $0)
                                ds_list_add(ild_list,i);
                                    //one extra line for fun
    i++;
    }
    
if (ds_list_size(ild_list) == 0)
    {
    show_message("This does not appear to be a valid ILDA file");
    return 0;
    }
format = buffer_peek(ild_file,7,buffer_u8);
if ((format == 0) or (format == 1) or (format == 2) or (format == 3) or (format == 6))
    {
    show_message("ILDA format "+string(format)+" is not supported. Try converting to type 4 or 5.");
    return 0;
    }    
     
ds_list_insert(ild_list,0,buffer_peek(ild_file,24,buffer_u8));
ds_list_insert(ild_list,0,format);
ds_list_insert(ild_list,0,ild_file);
if (ds_list_find_value(ds_list_find_value(scan_list,argument0),0) != 0)
    buffer_delete(ds_list_find_value(ds_list_find_value(scan_list,argument0),0));
ds_list_clear(ds_list_find_value(scan_list,argument0));
ds_list_replace(scan_list,argument0,ild_list);

    
ildaloaded = 1;

return 1;
