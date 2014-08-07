attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec2 pos;
varying vec4 v_vColor;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColor = in_Colour;
    v_vTexcoord = in_TextureCoord;
    pos = in_Position.xy;
}
//######################_==_YOYO_SHADER_MARKER_==_######################@~varying vec2 v_vTexcoord;
varying vec2 pos;
varying vec4 v_vColor;

const int num = 10;
float rand(vec2 n)
    {
    return fract(sin(n.x*5442.6542+n.y*5233.6531)*4354.5365);
    }
void main( void ) 
{
float Scale = 0.023;
float maxscale = 0.23;
float Color;
float Color2;
float S;
vec3 total;
for(int i = 0; i < num; i++)
    {
    S = mix(Scale,maxscale,float(i)/float(num));
    Color = mix(rand(ceil(pos*S)/S),rand(ceil(pos*S+vec2(1,0))/S),mod(pos.x*S,1.));
    Color2 = mix(rand(ceil(pos*S+vec2(0,1))/S),rand(ceil(pos*S+vec2(1,1))/S),mod(pos.x*S,1.));
    total += mix(Color,Color2,mod(pos.y*S,1.));
    }
total /= float(num);
vec4 tex = texture2D(gm_BaseTexture,v_vTexcoord) * v_vColor;
gl_FragColor = vec4( tex.r,tex.g,tex.b, (0.3+total*0.7) * tex.a );
}
