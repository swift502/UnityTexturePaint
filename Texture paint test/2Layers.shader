Shader "Custom/2Layers"
    {
        Properties
        {
            _ScaleOffset ("Global texture scale and offset", Vector) = (0.0,0.0,0.0,0.0)
            _Texture0 ("Texture 0", 2D) = "white" {}
            _Mask0 ("Mask 0", 2D) = "black" {}
            _Texture1 ("Texture 1", 2D) = "white" {}
            _Mask1 ("Mask 1", 2D) = "black" {}

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

                Texture2D _Texture0;
                Texture2D _Mask0;
                Texture2D _Texture1;
                Texture2D _Mask1;
                SamplerState sampler_linear_repeat;
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
                    col = lerp(col, _Texture1.Sample(sampler_linear_repeat, i.uv), _Mask1.Sample(sampler_linear_repeat, i.maskuv));

                    return col;
                }
                ENDCG
            }
        }
    }