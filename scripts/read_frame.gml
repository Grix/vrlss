i = 0;
loop = 1;
data = 0;
icp = ds_list_find_value(ild_list,frame);
frame_list = ds_list_create();

file_bin_seek(ild_file, i+icp-25);
format = file_bin_read_byte(ild_file);
ds_list_add(frame_list,format);
ds_list_add(frame_list,format);
ds_list_add(frame_list,format);
ds_list_add(frame_list,format);
ds_list_add(frame_list,format);
while (loop)
    {
    file_bin_seek(ild_file, i+icp);
    if ((i+icp) >= ds_list_find_value(ild_list,frame+1)) show_message("Error: "+string(i+icp)+"   "+string(data));
    byte = file_bin_read_byte(ild_file);
    
    
    if (format == 0) //format 0: old 3d
        {
        ds_list_add(frame_list,get_bytes());
        i += 2;
        if ((i+icp) >= ds_list_find_value(ild_list,frame+1)-4)
            {
            show_message(string(i+icp));
            loop = 0;
            }
        }
    else if (format == 5) //format 5: new 2d
        {
        switch (data)
            {
            case 0:
            case 1:
                ds_list_add(frame_list,get_bytes());
                i += 2; data++;
                break;
            case 2:
            case 3:
            case 4:
                ds_list_add(frame_list,byte);
                //show_message(string(i+icp)+"   "+string(data)+"   "+string(byte));
                i++; data++;
                break;
            case 5:
                ds_list_add(frame_list,byte);
                //show_message(string(i+icp)+"   "+"5   "+string(byte));
                i++;
                data = 0;
                if ((i+icp) >= ds_list_find_value(ild_list,frame+1)-4)
                    {
                    loop = 0;
                    }
                break;
            }
        }
    else if (format == 4) //format 4: new 3d
        {
        switch (data)
            {
            case 0:
            case 1:
            case 2:
                ds_list_add(frame_list,get_bytes());
                i += 2; data++;
                break;
            case 3:
            case 4:
            case 5:
                ds_list_add(frame_list,byte);
                i++; data++;
                break;
            case 6:
                ds_list_add(frame_list,byte);
                i++;
                data = 0;
            if ((i+icp) >= ds_list_find_value(ild_list,frame+1)-7)
                    {
                    loop = 0;
                    }
                break;
            }
        }
    }
