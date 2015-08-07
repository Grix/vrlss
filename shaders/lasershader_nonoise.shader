attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec3 pos;
varying vec4 v_vColor;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColor = in_Colour;
    v_vTexcoord = in_TextureCoord;
    pos = vec3(in_Position.x, in_Position.y, in_Position.z);
}
//######################_==_YOYO_SHADER_MARKER_==_######################@~varying vec2 v_vTexcoord;
varying vec3 pos;
varying vec4 v_vColor;
uniform float time;
uniform vec3 scanner_pos;
uniform vec3 player_pos;
      
float anglecheck(void)
    {
    vec3 sightline = normalize(vec3(player_pos.x - pos.x, player_pos.y - pos.y, player_pos.z - pos.z));
    vec3 laserline = normalize(vec3(pos.x - scanner_pos.x, pos.y - scanner_pos.y, pos.z - scanner_pos.z));
    return 0.3+(0.11/max((1.0-abs(dot(laserline,sightline))+0.015),0.01));
    }
    
float fade(void)
    {
    vec3 topoint = vec3(pos.x - scanner_pos.x, pos.y - scanner_pos.y, pos.z - scanner_pos.z);
    return 0.11/max(length(topoint)/25.0+0.03,0.01);
    }

void main( void ) 
    {
    float change = time * 0.00000017;
    vec4 tex = texture2D(gm_BaseTexture,v_vTexcoord) * v_vColor;
    gl_FragColor = vec4( tex.r,tex.g,tex.b, clamp(anglecheck()*fade()*0.5*tex.a,0.025,0.95) );
    }
