Shader "Root/HelloShader" {

	Properties {
		_colour ("Colour", Color) = (1,1,1,1)
		_emissionColour("Emission Colour", COLOR) = (1,1,1,1)
	}

	SubShader {
		CGPROGRAM
			#pragma surface surf Lambert
			
			struct Input
			{
				float2 uvMainTex;
			};

			fixed4 _colour;
			fixed4 _emissionColour;

			void surf (Input IN, inout SurfaceOutput o)
			{
				o.Albedo = _colour.rgb;
				o.Emission = _emissionColour.rgb;
			}

		ENDCG
	}

	FallBack "Diffuse"
}