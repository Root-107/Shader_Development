
Shader "Unlit/ShaderPlaneWhite"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_Texture2("Texture2", 2D) = "white" {}
		_Tween("Tween", Range(0,1)) = 0
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
			sampler2D _Texture2;
			fixed _Tween;
			
			fixed4 frag (v2f i) : SV_Target
			{
				//float value = _Tween;
				float4 color = tex2D(_MainTex, i.uv);
				float4 color2 = tex2D(_Texture2, i.uv);
				color = float4(color.r, color.g, color.b, color.a);
				color2 = float4(color2.r, color2.g, color2.b, color2.a);
				color = lerp(color, color2, _Tween);
				return color;
			}
			ENDCG
		}
	}
}
