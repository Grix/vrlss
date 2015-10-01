//reads the data points of the current frame in the ilda file

repeat(ds_list_find_value(frame_list,0))
    {
    repeat (2)//32
        {
        ds_list_add(frame_list,get_bytes_signed()); 
        i+=2;
        }
    if (format == 4) i+= 2;
    ds_list_add(frame_list,get_byte()); 
    i++;
    blue = get_byte();
    i++;
    green = get_byte();
    i++;
    red = get_byte();
    ds_list_add(frame_list,make_colour_rgb(red,green,blue)); 
    i++;
    }
ds_list_add(ild_list,frame_list);
