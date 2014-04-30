//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColor;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColor = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~varying vec2 v_vTexcoord;
varying vec4 v_vColor;

const int num = 8;
float rand(vec2 n)
    {
    return fract(sin(n.x*5442.6542+n.y*5233.6531)*4354.5365);
    }
void main( void ) {

float Scale = 4.0;
float maxscale = 10.0;
float Color;
float Color2;
vec3 total;
for(int i = 0; i < num; i++)
    {
    Scale = mix(Scale,maxscale,float(i)/float(num));
    Color = mix(rand(ceil(v_vTexcoord*Scale)/Scale),rand(ceil(v_vTexcoord*Scale+vec2(1,0))/Scale),mod(v_vTexcoord.x*Scale,1.));
    Color2 = mix(rand(ceil(v_vTexcoord*Scale+vec2(0,1))/Scale),rand(ceil(v_vTexcoord*Scale+vec2(1,1))/Scale),mod(v_vTexcoord.x*Scale,1.));
    total += mix(Color,Color2,mod(v_vTexcoord.y*Scale,1.));
    }
total /= float(num);

gl_FragColor = vec4( texture2D(gm_BaseTexture,v_vTexcoord).rgb, total );
}
