Shader "Root/Blending" {

	Properties {
		_MainTex("Main Texture", 2D) = "black" {}
	}

	SubShader {
		Tags {"Queue" = "Transparent"}

		Blend One One

		CGPROGRAM
			#pragma surface surf Lambert
			

			struct Input
			{
				float2 uv_MainTex;
			};

			sampler2D _MainTex;

			void surf (Input IN, inout SurfaceOutput o)
			{
				fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
				o.Albedo = tex.rgb;
			}

		ENDCG
	}

	FallBack "Diffuse"
}