icp = 0;

show_message("Please load ild file");
ild_file = file_bin_open(get_open_filename("*.ild",""),0);
file_size = file_bin_size(ild_file);
    if !(ild_file) 
        {
        show_message("Can't open file");
        return 0;
        }
    i = 0;
    ildastring = 0;

    ild_list = ds_list_create();
    
    while ((i) < file_size)
        {
        file_bin_seek(ild_file, i);
        byte = file_bin_read_byte(ild_file);
        switch (ildastring)
            {
            case 0:
                if (byte == $49)
                    {
                    ildastring++;
                    i--;
                    }
                break;
            case 1:
                if (byte == $4C)
                    {
                    ildastring++;
                    i--;
                    }
                else 
                    {
                    ildastring = 0;
                    i++;
                    }
                break;
            case 2:
                if (byte == $44)
                    {
                    ildastring++;
                    i--;
                    }
                else 
                    {
                    ildastring = 0;
                    i+=2;
                    }
                break;
            case 3:
                if (byte == $41)
                    {
                    ds_list_add(ild_list,i+29);
                    //show_message(i)
                    i+=24;
                    }
                i+= 3;
                ildastring = 0;
                break;
            }
        i+= 2;
        }
        
return 1;
