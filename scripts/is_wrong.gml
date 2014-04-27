//checks control bytes

if (byte != argument0)
    {
    show_message("Unexpected byte: "+string(i+icp)+" = "+string(byte)+". Is this a valid ILDA file?");
    return 0;
    }
else 
    return 1;
    //show_message("successful read at "+string(i+icp));
   
