//works its way through an ilda file, finishes early so that a frame can be drawn

progress = icp;

while (1)//(i+icp) < file_size-1)
    {
    //buffer_seek(ild_file, i+icp, 0);
    //byte = buffer_peek(ild_file, i+icp, buffer_u8); //buffer_read(ild_file, buffer_u8);
    //byterf = ord(RF_readpart(filename,i+icp,0));
    file_bin_seek(ild_file,i+icp);
    byte = file_bin_read_byte(ild_file);
    
    if (status) //read points
        {
        if (format == 4) //format 4: new 3d
            {
            point++;
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
                    if (point/7 >= ds_list_find_value(frame_list,0))
                        {
                        status = 0;
                        icp = icp+point*10/7+32;
                        i = 0;
                        point = 0;
                        ds_list_add(ild_list,frame_list);
                        
                        if (maxframes <= ds_list_size(ild_list))
                            {
                            ds_list_add(ild_list,"STOP");
                            ds_list_add(ild_list,maxframes);
                            ds_list_add(ild_list,"name");
                            ds_list_add(ild_list,"uu");
                            ds_list_add(ild_list,"uu");
                            }
                        if (!((i+icp) < file_size-1))
                            return 1;
                        if ((progress+157209) < icp)
                            return 0;
                        }
                    break;
                }
            }
        else if (format == 5) //format 5: new 2d
            {
            point++;
            switch (data)
                {
                case 0:
                case 1:
                    ds_list_add(frame_list,get_bytes());
                    //show_message(string(i+icp)+"   "+string(data)+"   "+string(get_bytes()));
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
                    if (point/6 >= ds_list_find_value(frame_list,0))
                        {
                        status = 0;
                        icp = icp+point*8/6+32;
                        i = 0;
                        point = 0;
                        ds_list_add(ild_list,frame_list);
                        if (maxframes <= ds_list_size(ild_list))
                            {
                            ds_list_add(ild_list,"STOP");
                            ds_list_add(ild_list,maxframes);
                            ds_list_add(ild_list,"name");
                            ds_list_add(ild_list,"uu");
                            ds_list_add(ild_list,"uu");
                            }
                        if (!((i+icp) < file_size-1))
                            return 1;
                        if ((progress+157209) < icp)
                            return 0;
                        }
                    break;
                }
            }            
        else if (format == 0) //format 0: old 3d
            {
            point++;
            ds_list_add(frame_list,get_bytes());
            i += 2;
            if (point/4 >= ds_list_find_value(frame_list,0))
                {
                status = 0;
                icp = icp+point*2+32;
                i = 0;
                point = 0;
                ds_list_add(ild_list,frame_list);
                if (maxframes <= ds_list_size(ild_list))
                    {
                    ds_list_add(ild_list,"STOP");
                    ds_list_add(ild_list,maxframes);
                    ds_list_add(ild_list,"name");
                    ds_list_add(ild_list,"uu");
                    ds_list_add(ild_list,"uu");
                    }
                if (!((i+icp) < file_size-1))
                    return 1;
                if ((progress+157209) < icp)
                    return 0;
                }
            }

        }  
    else// if !(status) //read header
        {
        switch (i)
            {
            case 0: if !is_wrong($49) return 0; break;
            case 1: if !is_wrong($4C) return 0; break;
            case 2: if !is_wrong($44) return 0; break;
            case 3: if !is_wrong($41) return 0; break;
            case 4: if !is_wrong($0) return 0; break;
            case 5: if !is_wrong($0) return 0; break;
            case 6: if !is_wrong($0) return 0; break;
            case 7: 
                if (byte == 4 or byte == 5) { format = byte; }
                else {show_message("We don't support this ILDA format yet, try converting to format 4 or 5"); game_end(); return 0;}
                if (byte == 0 and (file_size-(i+icp)) > 50) needpal = 1;
                break;
            case 8:
            case 9:
            case 10:
            case 11:
            case 12:
            case 13:
            case 14:
            case 15:
                name+= chr(byte);
                break;
            case 16:
            case 17:
            case 18:
            case 19:
            case 20:
            case 21:
            case 22:
            case 23:
                author+= chr(byte);
                break;
            case 24: 
                bytes = get_bytes();
                if (bytes != 0)
                    {
                    frame_list = ds_list_create();
                    ds_list_add(frame_list,bytes);
                    }
                break;
            case 26: frame_number = get_bytes(); break;
            case 28: maxframes = get_bytes(); break;
            case 30: ds_list_add(frame_list,byte); ds_list_add(frame_list,format); ds_list_add(frame_list,name); ds_list_add(frame_list,author); status = 1; i++; author=""; name="";
                if (!((i+icp) < file_size-1))
                    return 1;
                if ((progress+157209) < icp)
                    return 0;
                break;
            }
        i++;
        }
    }
        
//Todo: find out where this extra bogus frame comes from:
//ds_list_delete(ild_list,ds_list_size(ild_list)-1);

return 1;

