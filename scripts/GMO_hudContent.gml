//Here goes HUD drawing code, in a 960*1080 area representing each eye

draw_set_alpha(0.5);
draw_set_color(c_white);
draw_set_alpha(0.8);
draw_rectangle(960/  2-175,1080/2-70,960/2+175,1080/2+70,0);
draw_set_color(c_black);
draw_set_font(fnt_hud);
draw_text(960/2-150,1080/2-40,"Pitch: "+string(pitch)+
                    ", Yaw: "+string(yaw)+
                    ", Roll: "+string(roll)+
                    "#Device: X=" + string(dx) + " Y=" + string(dy) + " Z=" + string(dz) + "#IPD: "+string(GMO_getIPD*global._GC_Ratio/100)+" mm"
                    +"#FPS: "+string(fps));
draw_set_alpha(1);
