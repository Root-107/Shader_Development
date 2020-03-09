
Shader "Unlit/ShaderPlaneWhite"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_UVRepeat("Multiplyer", Range(1,10)) = 1
	}
	SubShader
	{
		Tags{
			"Queue" = "Transparent"
		}
		Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha

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
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
			};
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}

			sampler2D _MainTex;
			fixed _UVRepeat;
			
			fixed4 frag (v2f i) : SV_Target
			{
				float4 color = tex2D(_MainTex, i.uv * _UVRepeat);
				return color;
			}
			ENDCG
		}
	}
}
