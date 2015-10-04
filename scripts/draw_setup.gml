if (!surface_exists(setup_surf1))
    {
    setup_surf1 = surface_create(512,512);
    refresh_setup_surf = 1;
    }
if (!surface_exists(setup_surf2))
    {
    setup_surf2 = surface_create(512,512);
    refresh_setup_surf = 1;
    }
if (!surface_exists(setup_surf3))
    {
    setup_surf3 = surface_create(512,512);
    refresh_setup_surf = 1;
    }
if (!surface_exists(setup_surf4))
    {
    setup_surf4 = surface_create(512,512);
    refresh_setup_surf = 1;
    }
    
refresh_setup_surf = 1;
if (refresh_setup_surf == 1)
    {
    refresh_setup_surf = 0;
    
    surface_set_target(setup_surf1);
        draw_clear_alpha(c_white,0);
    surface_reset_target();
    surface_set_target(setup_surf2);
        draw_clear_alpha(c_white,0);
    surface_reset_target();
    surface_set_target(setup_surf3);
        draw_clear_alpha(c_white,0);
    surface_reset_target();
    surface_set_target(setup_surf4);
        draw_clear_alpha(c_white,0);
    surface_reset_target();
    
    with (obj_miniscanner)
        {
        if (controller.rdy and rdy)
            {
            if (mode == 2)
                surface_set_target(controller.setup_surf2);
            else if (mode == 3)
                surface_set_target(controller.setup_surf3);
            else if (mode == 4)
                surface_set_target(controller.setup_surf4);
            else exit;
            
            draw_set_font(fnt_parsing);
            draw_set_color(c_ltgray);
            draw_text(x-4,y-7,scanner);
            
            if (controller.selected_scanner == scanner)
                {
                if (master)
                    draw_set_color(c_red);
                else draw_set_color(c_purple);
                }
            else
                {
                if (master)
                    draw_set_color(c_ltgray);
                else draw_set_color(c_dkgray);
                }
            draw_circle(x,y,15,1);
            
            if (master)
                {
                draw_circle(x,y-35,15,1);
                draw_sprite(spr_angle,mode-2,x,y-35);
                }
            
            if (mode == 2)
                {
                surface_set_target(controller.setup_surf2);
                draw_set_alpha(alpha+0.5);
                
                if (angle/2 == pi/4)
                    angle +=0.0001;
                
                divcp = cos(yrad+angle/2);
                if (divcp == 0)
                    divcp = 0.000001;
                divcm = cos(yrad-angle/2);
                if (divcm == 0)
                    divcm = 0.000001;
                    
                xpos1 = x+25*(      sin(yrad+pi/2+angle/2)*cos(-xrad+pi/2+angle/2))/divcp;
                zpos1 = y+35+20*(   cos(yrad+pi/2+angle/2)); 
                xpos2 = x+25*(      sin(yrad+pi/2-angle/2)*cos(-xrad+pi/2+angle/2))/divcm;
                zpos2 = y+35+20*(   cos(yrad+pi/2-angle/2)); 
                xpos3 = x+25*(      sin(yrad+pi/2-angle/2)*cos(-xrad+pi/2-angle/2))/divcm;
                zpos3 = y+35+20*(   cos(yrad+pi/2-angle/2)); 
                xpos4 = x+25*(      sin(yrad+pi/2+angle/2)*cos(-xrad+pi/2-angle/2))/divcp;
                zpos4 = y+35+20*(   cos(yrad+pi/2+angle/2)); 
                
                draw_line(xpos2,zpos2,xpos1,zpos1);
                draw_line(xpos2,zpos2,xpos3,zpos3);
                draw_line(xpos3,zpos3,xpos4,zpos4);
                draw_line(xpos4,zpos4,xpos1,zpos1);
                draw_line(x,y+35,xpos1,zpos1);
                draw_line(x,y+35,xpos2,zpos2);
                draw_line(x,y+35,xpos3,zpos3);
                draw_line(x,y+35,xpos4,zpos4);
                
                draw_set_alpha(1);
                }
            else if (mode == 3)
                {
                if (controller.selected_scanner == scanner)
                    {
                    if (master)
                        draw_set_color(c_red);
                    else draw_set_color(c_purple);
                    }
                else
                    {
                    if (master)
                        draw_set_color(c_ltgray);
                    else draw_set_color(c_dkgray);
                    }
                draw_set_alpha_test(0);
                draw_set_alpha(alpha+0.25);
                draw_triangle(x,y,x+256*cos(pi/2-xrad+angle/2),y+256*sin(pi/2-xrad+angle/2),x+256*cos(pi/2-xrad-angle/2),y+256*sin(pi/2-xrad-angle/2),0); 
                draw_set_color(c_white);
                draw_set_alpha(1);
                }
            else if (mode == 4)
                {
                if (controller.selected_scanner == scanner)
                    {
                    draw_set_color(c_red);
                    }
                else
                    {
                    draw_set_color(c_ltgray);
                    }
                    
                draw_set_alpha_test(0);
                draw_set_alpha(alpha+0.25);    
                draw_triangle(x,y,x+256*cos(pi+yrad+angle/2),y+256*sin(pi+yrad+angle/2),x+256*cos(pi+yrad-angle/2),y+256*sin(pi+yrad-angle/2),0);
                draw_set_color(c_white);
                draw_set_alpha(1);
                }
                
            surface_reset_target();
            }
        }
    }

//draw_surface_part(setup_surf1,0,0,256,256,0,0);
draw_surface_part(setup_surf2,256,0,256,256,256,0);
draw_surface_part(setup_surf3,0,256,256,256,0,256);
draw_surface_part(setup_surf4,256,256,256,256,256,256);
    
