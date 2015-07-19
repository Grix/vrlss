//initializes parsing of an ilda file
//arg0 is scanner number
//return 1 if successful

saud_stop(audio);
frame = 0;
play = 0;

filename = get_open_filename_ext("ILDA files|*.ild","","","Select ILDA file")
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
if !is_wrong($49)
    return 0;i++;
if !is_wrong($4C)
    return 0;i++; 
if !is_wrong($44) 
    return 0;i++;
if !is_wrong($41) 
    return 0;i++;
if !is_wrong($0)
    return 0;i++;
if !is_wrong($0)
    return 0;i++;
if !is_wrong($0)
    return 0;i=0;

rdy = 0;
filename = "";

i = 0;
format = 0;
    
ild_list = ds_list_create();
ds_list_add(scan_list,ild_list);

instance_deactivate_all(1);
    
alarm[2]=1;

read_ilda_header_first();
read_ilda_frame();

return 1;
