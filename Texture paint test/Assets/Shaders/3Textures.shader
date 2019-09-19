Shader "Custom/3Textures"
{
    Properties
    {
		_ScaleOffset ("Global texture scale and offset", Vector) = (0.0,0.0,0.0,0.0)
        _TextureA ("Texture A", 2D) = "white" {}
		_TextureB ("Texture B", 2D) = "white" {}
		_MaskB ("Mask B", 2D) = "black" {}
		_TextureC ("Texture C", 2D) = "white" {}
		_MaskC ("Mask C", 2D) = "black" {}
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

			sampler2D _TextureA;
			sampler2D _TextureB;
			sampler2D _MaskB;
			sampler2D _TextureC;
			sampler2D _MaskC;
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
                fixed4 col = tex2D(_TextureA, i.uv);
				col = lerp(col, tex2D(_TextureB, i.uv), tex2D(_MaskB, i.maskuv));
				col = lerp(col, tex2D(_TextureC, i.uv), tex2D(_MaskC, i.maskuv));
                return col;
            }
            ENDCG
        }
    }
}