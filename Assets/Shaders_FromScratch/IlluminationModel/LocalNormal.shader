Shader "Root/NormalDataLocal" {

	Properties {

	}

	SubShader {
		CGPROGRAM
			#pragma surface surf Lambert
			
			struct Input
			{
				float2 uvMainTex;
			};



			void surf (Input IN, inout SurfaceOutput o)
			{
				o.Albedo = o.Normal;
			}

		ENDCG
	}

	FallBack "Diffuse"
}