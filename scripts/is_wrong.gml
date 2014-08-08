//checks control bytes

if (get_byte() != argument0)
    {
    show_message("Cannot load ILDA file. Unexpected byte: "+string(i+icp)+" = "+string(get_byte)+". Is this a valid ILDA file?");
    return 0;
    }
else 
    return 1;
    //show_message("successful read at "+string(i+icp));
   
