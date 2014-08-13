    if !is_wrong($49) return 0;
i++;
    if !is_wrong($4C) return 0;
i += 6; //7
    byte = get_byte();
    if (byte == 4 or byte == 5) { format = byte; }
    else {show_message("We don't support this ILDA format yet, try converting to format 4 or 5"); game_end(); return 0;}
    if (byte == 0 and (file_size-(i)) > 50) needpal = 1;
    i++;
repeat(8) //8
    {
    name+= chr(get_byte());
    i++
    }
repeat(8) //16
    {
    author+= chr(get_byte());
    i++
    }
bytes = get_bytes(); //24
if (bytes != 0)
    {
    frame_list = ds_list_create();
    ds_list_add(frame_list,bytes);
    }
i+=2;
//26
frame_number = get_bytes();
i+=2;
//28
maxframes = get_bytes();
i+=2; //30
ds_list_add(frame_list,byte); ds_list_add(frame_list,format); ds_list_add(frame_list,name); ds_list_add(frame_list,author); status = 1; i++; author=""; name="";
i++;
if (frame_number >= maxframes)
    return 1;

if !(frame_number % 50)
    return 2;
    
return 0;