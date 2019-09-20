Shader "Custom/9Layers"
    {
        Properties
        {
            _ScaleOffset ("Global texture scale and offset", Vector) = (0.0,0.0,0.0,0.0)
            _Texture0 ("Texture 0", 2D) = "white" {}
            _Mask0 ("Mask 0", 2D) = "black" {}
            _Texture1 ("Texture 1", 2D) = "white" {}
            _Mask1 ("Mask 1", 2D) = "black" {}
            _Texture2 ("Texture 2", 2D) = "white" {}
            _Mask2 ("Mask 2", 2D) = "black" {}
            _Texture3 ("Texture 3", 2D) = "white" {}
            _Mask3 ("Mask 3", 2D) = "black" {}
            _Texture4 ("Texture 4", 2D) = "white" {}
            _Mask4 ("Mask 4", 2D) = "black" {}
            _Texture5 ("Texture 5", 2D) = "white" {}
            _Mask5 ("Mask 5", 2D) = "black" {}
            _Texture6 ("Texture 6", 2D) = "white" {}
            _Mask6 ("Mask 6", 2D) = "black" {}
            _Texture7 ("Texture 7", 2D) = "white" {}
            _Mask7 ("Mask 7", 2D) = "black" {}
            _Texture8 ("Texture 8", 2D) = "white" {}
            _Mask8 ("Mask 8", 2D) = "black" {}

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
                Texture2D _Texture2;
                Texture2D _Mask2;
                Texture2D _Texture3;
                Texture2D _Mask3;
                Texture2D _Texture4;
                Texture2D _Mask4;
                Texture2D _Texture5;
                Texture2D _Mask5;
                Texture2D _Texture6;
                Texture2D _Mask6;
                Texture2D _Texture7;
                Texture2D _Mask7;
                Texture2D _Texture8;
                Texture2D _Mask8;
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
                    col = lerp(col, _Texture2.Sample(sampler_linear_repeat, i.uv), _Mask2.Sample(sampler_linear_repeat, i.maskuv));
                    col = lerp(col, _Texture3.Sample(sampler_linear_repeat, i.uv), _Mask3.Sample(sampler_linear_repeat, i.maskuv));
                    col = lerp(col, _Texture4.Sample(sampler_linear_repeat, i.uv), _Mask4.Sample(sampler_linear_repeat, i.maskuv));
                    col = lerp(col, _Texture5.Sample(sampler_linear_repeat, i.uv), _Mask5.Sample(sampler_linear_repeat, i.maskuv));
                    col = lerp(col, _Texture6.Sample(sampler_linear_repeat, i.uv), _Mask6.Sample(sampler_linear_repeat, i.maskuv));
                    col = lerp(col, _Texture7.Sample(sampler_linear_repeat, i.uv), _Mask7.Sample(sampler_linear_repeat, i.maskuv));
                    col = lerp(col, _Texture8.Sample(sampler_linear_repeat, i.uv), _Mask8.Sample(sampler_linear_repeat, i.maskuv));

                    return col;
                }
                ENDCG
            }
        }
    }