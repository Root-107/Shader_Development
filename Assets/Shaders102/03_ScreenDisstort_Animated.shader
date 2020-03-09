Shader "Unlit/UVCords"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		_DisplaceTex("displaceTex", 2D) = "white" {}
		_Magnitude("magnitude", Range(0,0.1)) = 1
	}
	SubShader
	{
		Cull Off ZWrite Off ZTest Always

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
			sampler2D _DisplaceTex;
			fixed _Magnitude;

			fixed4 frag (v2f i) : SV_Target
			{
				float2 distuv = float2(i.uv.x + _Time.x * 2, i.uv.y + _Time.x * 2);

				float2 disp = tex2D(_DisplaceTex, distuv).xy;
				disp = ((disp * 2) - 1) * _Magnitude;

				float4 col = tex2D(_MainTex, i.uv + disp);
				return col;
			}
			ENDCG
		}
	}
}
