//returns two next bytes combined

byte0 = byte;
//byterf0 = byterf;
//byterf0 = string_byte_at(rfstring,1);
//byterf1 = string_byte_at(rfstring,2);
//file_bin_seek(ild_file,i+icp+1);
//byte1 = file_bin_read_byte(ild_file);
//buffer_seek(ild_file, i+icp+1, 0);
byte1 = buffer_peek(ild_file, i+1,buffer_u8);

//file_bin_seek(ild_file,i+1);
//byte1 = file_bin_read_byte(ild_file);
//wordrf = (byterf0 << 8) + byterf1;
return((byte0 << 8) + byte1);
