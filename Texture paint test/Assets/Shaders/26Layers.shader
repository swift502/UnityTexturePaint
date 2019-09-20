Shader "Custom/26Layers"
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
            _Texture9 ("Texture 9", 2D) = "white" {}
            _Mask9 ("Mask 9", 2D) = "black" {}
            _Texture10 ("Texture 10", 2D) = "white" {}
            _Mask10 ("Mask 10", 2D) = "black" {}
            _Texture11 ("Texture 11", 2D) = "white" {}
            _Mask11 ("Mask 11", 2D) = "black" {}
            _Texture12 ("Texture 12", 2D) = "white" {}
            _Mask12 ("Mask 12", 2D) = "black" {}
            _Texture13 ("Texture 13", 2D) = "white" {}
            _Mask13 ("Mask 13", 2D) = "black" {}
            _Texture14 ("Texture 14", 2D) = "white" {}
            _Mask14 ("Mask 14", 2D) = "black" {}
            _Texture15 ("Texture 15", 2D) = "white" {}
            _Mask15 ("Mask 15", 2D) = "black" {}
            _Texture16 ("Texture 16", 2D) = "white" {}
            _Mask16 ("Mask 16", 2D) = "black" {}
            _Texture17 ("Texture 17", 2D) = "white" {}
            _Mask17 ("Mask 17", 2D) = "black" {}
            _Texture18 ("Texture 18", 2D) = "white" {}
            _Mask18 ("Mask 18", 2D) = "black" {}
            _Texture19 ("Texture 19", 2D) = "white" {}
            _Mask19 ("Mask 19", 2D) = "black" {}
            _Texture20 ("Texture 20", 2D) = "white" {}
            _Mask20 ("Mask 20", 2D) = "black" {}
            _Texture21 ("Texture 21", 2D) = "white" {}
            _Mask21 ("Mask 21", 2D) = "black" {}
            _Texture22 ("Texture 22", 2D) = "white" {}
            _Mask22 ("Mask 22", 2D) = "black" {}
            _Texture23 ("Texture 23", 2D) = "white" {}
            _Mask23 ("Mask 23", 2D) = "black" {}
            _Texture24 ("Texture 24", 2D) = "white" {}
            _Mask24 ("Mask 24", 2D) = "black" {}
            _Texture25 ("Texture 25", 2D) = "white" {}
            _Mask25 ("Mask 25", 2D) = "black" {}

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
                Texture2D _Texture9;
                Texture2D _Mask9;
                Texture2D _Texture10;
                Texture2D _Mask10;
                Texture2D _Texture11;
                Texture2D _Mask11;
                Texture2D _Texture12;
                Texture2D _Mask12;
                Texture2D _Texture13;
                Texture2D _Mask13;
                Texture2D _Texture14;
                Texture2D _Mask14;
                Texture2D _Texture15;
                Texture2D _Mask15;
                Texture2D _Texture16;
                Texture2D _Mask16;
                Texture2D _Texture17;
                Texture2D _Mask17;
                Texture2D _Texture18;
                Texture2D _Mask18;
                Texture2D _Texture19;
                Texture2D _Mask19;
                Texture2D _Texture20;
                Texture2D _Mask20;
                Texture2D _Texture21;
                Texture2D _Mask21;
                Texture2D _Texture22;
                Texture2D _Mask22;
                Texture2D _Texture23;
                Texture2D _Mask23;
                Texture2D _Texture24;
                Texture2D _Mask24;
                Texture2D _Texture25;
                Texture2D _Mask25;
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
                    col = lerp(col, _Texture9.Sample(sampler_linear_repeat, i.uv), _Mask9.Sample(sampler_linear_repeat, i.maskuv));
                    col = lerp(col, _Texture10.Sample(sampler_linear_repeat, i.uv), _Mask10.Sample(sampler_linear_repeat, i.maskuv));
                    col = lerp(col, _Texture11.Sample(sampler_linear_repeat, i.uv), _Mask11.Sample(sampler_linear_repeat, i.maskuv));
                    col = lerp(col, _Texture12.Sample(sampler_linear_repeat, i.uv), _Mask12.Sample(sampler_linear_repeat, i.maskuv));
                    col = lerp(col, _Texture13.Sample(sampler_linear_repeat, i.uv), _Mask13.Sample(sampler_linear_repeat, i.maskuv));
                    col = lerp(col, _Texture14.Sample(sampler_linear_repeat, i.uv), _Mask14.Sample(sampler_linear_repeat, i.maskuv));
                    col = lerp(col, _Texture15.Sample(sampler_linear_repeat, i.uv), _Mask15.Sample(sampler_linear_repeat, i.maskuv));
                    col = lerp(col, _Texture16.Sample(sampler_linear_repeat, i.uv), _Mask16.Sample(sampler_linear_repeat, i.maskuv));
                    col = lerp(col, _Texture17.Sample(sampler_linear_repeat, i.uv), _Mask17.Sample(sampler_linear_repeat, i.maskuv));
                    col = lerp(col, _Texture18.Sample(sampler_linear_repeat, i.uv), _Mask18.Sample(sampler_linear_repeat, i.maskuv));
                    col = lerp(col, _Texture19.Sample(sampler_linear_repeat, i.uv), _Mask19.Sample(sampler_linear_repeat, i.maskuv));
                    col = lerp(col, _Texture20.Sample(sampler_linear_repeat, i.uv), _Mask20.Sample(sampler_linear_repeat, i.maskuv));
                    col = lerp(col, _Texture21.Sample(sampler_linear_repeat, i.uv), _Mask21.Sample(sampler_linear_repeat, i.maskuv));
                    col = lerp(col, _Texture22.Sample(sampler_linear_repeat, i.uv), _Mask22.Sample(sampler_linear_repeat, i.maskuv));
                    col = lerp(col, _Texture23.Sample(sampler_linear_repeat, i.uv), _Mask23.Sample(sampler_linear_repeat, i.maskuv));
                    col = lerp(col, _Texture24.Sample(sampler_linear_repeat, i.uv), _Mask24.Sample(sampler_linear_repeat, i.maskuv));
                    col = lerp(col, _Texture25.Sample(sampler_linear_repeat, i.uv), _Mask25.Sample(sampler_linear_repeat, i.maskuv));

                    return col;
                }
                ENDCG
            }
        }
    }