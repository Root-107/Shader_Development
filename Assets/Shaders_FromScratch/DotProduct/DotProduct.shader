Shader "Root/DontProduct" {

	Properties {
		_colour ("Colour", Color) = (1,1,1,1)
		_Highlight("HighlightColour", Color) = (1,1,1,1)
	}

	SubShader {

		CGPROGRAM
			#pragma surface surf Lambert
			
			struct Input
			{
				float2 uvMainTex;
				float3 viewDir;
			};

			fixed4 _colour;
			fixed4 _Highlight;

			void surf (Input IN, inout SurfaceOutput o)
			{
				half dotp = 1-dot(IN.viewDir, o.Normal);
				half dotp2 = dot(IN.viewDir, o.Normal);

				o.Albedo = float3(dotp, 1, 1);
				o.Albedo += float3(0, 0, dotp2);
			}

		ENDCG
	}

	FallBack "Diffuse"
}