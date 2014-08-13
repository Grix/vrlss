
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
    
i = 0;
if !is_wrong($49) return 0;
    
    

rdy = 0;
frame = 0;
play = 0;
progress = 0;
filename = "";
saud_stop(audio);

    i = 0;
    format = 0;
    name = "";
    author = "";


    ds_list_clear(ds_list_find_value(scan_list,argument0));
    ild_list = ds_list_create();
    ds_list_replace(scan_list,argument0,ild_list);
    
alarm[2]=1;

read_ilda_header()
read_ilda_frame()

return 1;
