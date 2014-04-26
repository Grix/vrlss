//initializes parsing of an ilda file, stores each frame in its own ds_list, a catalog of frames is kept in another ds_list
//arg0 is scanner number
if (!argument0)
    show_message("Please load ILDA file for main center scanner.");
else
    show_message("Please load ILDA file for secondary flanking scanners.");
    
//ild_file = file_bin_open(get_open_filename("*.ild",""),0);
//ild_file = working_directory+"\GotGlint.ild"; //GMBINOpenFileRead(get_open_filename("*.ild",""));

rdy = 0;
play = 0;
progress = 0;
filename = "";
saud_stop(audio);

filename = get_open_filename_ext("*.ild","*",working_directory,"Select ILDA file")
if (filename != "")
    ild_file = file_bin_open(filename,0);
else
    return 0;
file_size = file_bin_size(ild_file);
//file_bin_close(ild_file);
//ild_file = buffer_create(file_size,buffer_fast,1);
//buffer_fill(ild_file,0,buffer_u8,real(RF_readall(filename)),file_size);
//buffer_load_ext(ild_file,filename,0);

//file_size = file_bin_size(ild_file);
    if !(ild_file) 
        {
        //show_message("Can't open file");
        //game_end();
        }
    point = 0;
    i = 0;
    icp = 0;
    status = 0;
    fin = 0;
    format = 0;
    data = 0;
    needpal = 0;
    name = "";
    author = "";
    //instance_create(0,0,obj_loading);

    ild_list = ds_list_create();
    ds_list_replace(scan_list,argument0,ild_list);
    
alarm[2]=1;
return 1;
