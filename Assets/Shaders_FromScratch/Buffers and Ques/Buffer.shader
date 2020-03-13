Shader "Root/Buffer" {

	Properties {
		_colour ("Colour", Color) = (1,1,1,1)
	}

	SubShader {

		ZWrite Off
		Tags {"Queue" = "Geometry+100"}

		CGPROGRAM
			#pragma surface surf Lambert
			
			struct Input
			{
				float2 uvMainTex;
			};

			fixed4 _colour;

			void surf (Input IN, inout SurfaceOutput o)
			{
				o.Albedo = _colour.rgb;
			}

		ENDCG
	}

	FallBack "Diffuse"
}