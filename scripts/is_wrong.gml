#define is_wrong
//checks control bytes

if (byte != argument0)
    {
    show_message("Cannot load ILDA file. Unexpected byte: "+string(i+icp)+" = "+string(byte)+". Is this a valid ILDA file?");
    game_end();
    return 0;
    }
else 
    return 1;
    //show_message("successful read at "+string(i+icp));
   