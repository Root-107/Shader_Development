// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Root/Glass"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_BumpMap ("Normalmap", 2D) = "bump" {}
		_ScaleUV ("Scale", Range(0,2)) = 1
	}

	SubShader
	{
		Tags{ "Queue" = "Transparent"}

		GrabPass{ "_GrabTexture" }

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : POSITION;
				fixed4 color : COLOR;
				float2 texcoord : TEXCOORD0;
 
				float4 uvgrab : TEXCOORD1;
			};

			sampler2D _GrabTexture;
 
			sampler2D _MainTex;
			float4 _MainTex_ST;
 
			sampler2D _BumpMap;
			float4 _BumpMap_ST;

			float  _ScaleUV;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.color = v.color;
 
				o.texcoord = v.texcoord;
 
				o.uvgrab = ComputeGrabScreenPos(o.vertex);

				o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
				o.texcoord = TRANSFORM_TEX(v.texcoord, _BumpMap);

				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				half4 mainColour = tex2D(_MainTex, i.texcoord);
				half4 bump = tex2D(_BumpMap, i.texcoord);
				half2 distortion = UnpackNormal(bump).rg;

				i.uvgrab.xy += distortion * _ScaleUV;

				fixed4 col = tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(i.uvgrab));
				return col * mainColour;
			}
			ENDCG
		}
	}
}

