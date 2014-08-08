//works its way through an ilda file, finishes early so that a frame 
//can be drawn with the progress information

while (1)
    {
    action = read_ilda_header();
    if (action == 1)
        {
        rdy = 1;
        exit;
        }
    read_ilda_frame();
    if (action == 2)
        {
        alarm[2] = 1;
        exit;
        }
    }
