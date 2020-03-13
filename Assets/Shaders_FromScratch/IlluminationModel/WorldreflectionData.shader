Shader "Root/NormalLocal" {

	Properties {

	}

	SubShader {
		CGPROGRAM
			#pragma surface surf Lambert
			
			struct Input
			{
				float2 uvMainTex;
				float3 worldRefl;
			};



			void surf (Input IN, inout SurfaceOutput o)
			{
				o.Albedo = IN.worldRefl.rgb;
			}

		ENDCG
	}

	FallBack "Diffuse"
}