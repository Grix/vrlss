repeat(ds_list_find_value(frame_list,0))
    {
    repeat (2 + (format == 4) )//32
        {
        byte = get_byte();
        ds_list_add(frame_list,get_bytes()); 
        //show_message(string(i+icp)+"   "+string(data)+"   "+string(get_bytes()));
        i+=2;
        }
    repeat (3)//34
        {
        ds_list_add(frame_list,get_byte());
        //show_message(string(i+icp)+"   "+string(data)+"   "+string(byte));
        i++;
        }
    ds_list_add(frame_list,get_byte()); //36/37
    //show_message(string(i+icp)+"   "+"5   "+string(byte));
    i++;
    }
ds_list_add(ild_list,frame_list);
