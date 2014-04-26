//initialize variables
xx = argument0;
yy = argument1;
str = argument2;
stroke_width = 2;

var i j;

draw_set_color(c_black); //set stroke color

for (i=-stroke_width;i<stroke_width;i+=1) { //stroke on x-axis
    for (j=-stroke_width;j<stroke_width;j+=1) { // stroke on y-axis
        draw_text(xx+i,yy+j,string(str)); //draw the text a bunch of times to make up the text
    }
}

draw_set_color(c_white); //set the color of the text
draw_text(xx,yy,string(str)); //draw the text
