repeat(ds_list_find_value(frame_list,0))
    {
    repeat (2 + (format == 4) )
        {
        ds_list_add(frame_list,get_bytes_signed()); 
        i+=2;
        }
    repeat (4)
        {
        ds_list_add(frame_list,get_byte());
        i++;
        }
    }
ds_list_add(ild_list,frame_list);