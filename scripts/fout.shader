float4 vec4(float x0, float x1, float x2, float3 x3)
{
    return float4(x0, x1, x2, x3.x);
}
// Varyings
static float2 _pos = {0, 0};
static float4 _v_vColor = {0, 0, 0, 0};
static float2 _v_vTexcoord = {0, 0};

static float4 gl_Color[1] =
{
    float4(0, 0, 0, 0)
};


uniform float _gm_AlphaRefValue : register(c3);
uniform bool _gm_AlphaTestEnabled : register(c4);
uniform sampler2D _gm_BaseTexture : register(s0);
uniform float4 _gm_FogColour : register(c5);
uniform bool _gm_PS_FogEnabled : register(c6);

float4 gl_texture2D(sampler2D s, float2 t)
{
    return tex2D(s, t);
}

#define GL_USES_FRAG_COLOR
float mod(float x, float y)
{
    return x - y * floor(x / y);
}

;
;
;
;
;
void _DoAlphaTest(in float4 _SrcColour)
{
{
if(_gm_AlphaTestEnabled)
{
{
if((_SrcColour.w <= _gm_AlphaRefValue))
{
{
discard;
;
}
;
}
;
}
;
}
;
}
}
;
void _DoFog(inout float4 _SrcColour, in float _fogval)
{
{
if(_gm_PS_FogEnabled)
{
{
(_SrcColour = lerp(_SrcColour, _gm_FogColour, clamp(_fogval, 0.0, 1.0)));
}
;
}
;
}
}
;
;
;
;
float _rand(in float2 _n)
{
{
return frac((sin(((_n.x * 5442.6543) + (_n.y * 5233.6533))) * 4354.5366));
;
}
}
;
void gl_main()
{
{
float _Scale = 0.02;
float _maxscale = 0.2;
float _Color = {0};
float _Color2 = {0};
float _S = {0};
float3 _total = {0, 0, 0};
{for(int _i = 0; (_i < 10); (_i++))
{
{
(_S = lerp(_Scale, _maxscale, (float(_i) / 10.0)));
(_Color = lerp(_rand((ceil((_pos * _S)) / _S)), _rand((ceil(((_pos * _S) + float2(1.0, 0.0))) / _S)), mod((_pos.x * _S), 1.0)));
(_Color2 = lerp(_rand((ceil(((_pos * _S) + float2(0.0, 1.0))) / _S)), _rand((ceil(((_pos * _S) + float2(1.0, 1.0))) / _S)), mod((_pos.x * _S), 1.0)));
(_total += lerp(_Color, _Color2, mod((_pos.y * _S), 1.0)));
}
;}
}
;
(_total /= 10.0);
float4 _tex = (gl_texture2D(_gm_BaseTexture, _v_vTexcoord) * _v_vColor);
(gl_Color[0] = vec4(_tex.x, _tex.y, _tex.z, (_total * _tex.w)));
}
}
;
struct PS_INPUT
{
    float4 v0 : TEXCOORD0;
    float2 v1 : TEXCOORD1;
    float2 v2 : TEXCOORD2;
};

struct PS_OUTPUT
{
    float4 gl_Color0 : COLOR0;
};

PS_OUTPUT main(PS_INPUT input)
{
    _v_vColor = input.v0;
    _pos = input.v1.xy;
    _v_vTexcoord = input.v2.xy;

    gl_main();

    PS_OUTPUT output;
    output.gl_Color0 = gl_Color[0];

    return output;
}
