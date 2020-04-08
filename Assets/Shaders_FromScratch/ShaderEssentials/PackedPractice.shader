Shader "Root/PackedPractice" {

	Properties {
		_colour ("Colour", Color) = (1,1,1,1)
	}

	SubShader {
		CGPROGRAM
			#pragma surface surf Lambert
			
			struct Input
			{
				float2 uvMainTex;
			};

			fixed4 _colour;

			void surf (Input IN, inout SurfaceOutput o)
			{
				o.Albedo = _colour.rbg;
			}

		ENDCG
	}

	FallBack "Diffuse"
}