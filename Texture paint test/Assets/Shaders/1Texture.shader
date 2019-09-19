Shader "Custom/1Texture"
{
    Properties
    {
		_ScaleOffset ("Global texture scale and offset", Vector) = (0.0,0.0,0.0,0.0)
        _TextureA ("Texture A", 2D) = "white" {}
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
                float4 vertex : SV_POSITION;
            };

			sampler2D _TextureA;
			fixed4 _ScaleOffset;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv * _ScaleOffset.xy + _ScaleOffset.zw;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_TextureA, i.uv);
                return col;
            }
            ENDCG
        }
    }
}