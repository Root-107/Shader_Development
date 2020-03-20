Shader "Root/AlphaShader" {

	Properties {
		_MainTex("Main Texture", 2D) = "White" {}
	}

	SubShader {
		Tags {"Queue" = "Transparent"}

		Cull Off

		CGPROGRAM
			#pragma surface surf Lambert alpha:fade
			

			struct Input
			{
				float2 uv_MainTex;
			};

			sampler2D _MainTex;

			void surf (Input IN, inout SurfaceOutput o)
			{
				fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
				o.Albedo = tex.rgb;
				o.Alpha = tex.a;
			}

		ENDCG
	}

	FallBack "Diffuse"
}