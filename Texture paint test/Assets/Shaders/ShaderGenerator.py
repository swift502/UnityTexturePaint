def getShader(shaderVariants):
    shader = 'Shader "Custom/{}Layers"'.format(shaderVariants)
    shader += '''
    {
        Properties
        {
            _ScaleOffset ("Global texture scale and offset", Vector) = (0.0,0.0,0.0,0.0)
'''

    for x in range(shaderVariants):
        shader += '            _Texture{} ("Texture {}", 2D) = "white" {{}}\n'.format(x, x)
        shader += '            _Mask{} ("Mask {}", 2D) = "black" {{}}\n'.format(x, x)

    shader += '''
        }
        SubShader
        {
            Tags { "RenderType"="Opaque" }
            LOD 100

            Pass
            {
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag

                #include "UnityCG.cginc"

                struct appdata
                {
                    float4 vertex : POSITION;
                    float2 uv : TEXCOORD0;
                };

                struct v2f
                {
                    float2 uv : TEXCOORD0;
                    float2 maskuv : TEXCOORD1;
                    float4 vertex : SV_POSITION;
                };

'''

    for x in range(shaderVariants):
        shader += '                Texture2D _Texture{};\n'.format(x)
        shader += '                Texture2D _Mask{};\n'.format(x)

    shader += '''                SamplerState sampler_linear_repeat;
                fixed4 _ScaleOffset;

                v2f vert (appdata v)
                {
                    v2f o;
                    o.vertex = UnityObjectToClipPos(v.vertex);
                    o.maskuv =v.uv;
                    o.uv = v.uv * _ScaleOffset.xy + _ScaleOffset.zw;
                    return o;
                }

                fixed4 frag (v2f i) : SV_Target
                {
                    fixed4 col = _Texture0.Sample(sampler_linear_repeat, i.uv);
'''

    for x in range(1, shaderVariants):
        shader += '                    col = lerp(col, _Texture{}.Sample(sampler_linear_repeat, i.uv), _Mask{}.Sample(sampler_linear_repeat, i.maskuv));\n'.format(x, x)

    shader += '''
                    return col;
                }
                ENDCG
            }
        }
    }'''

    return shader

for x in range(1, 33):
    with open(str(x)+'Layers.shader', 'w') as the_file:
        the_file.write(getShader(x))
