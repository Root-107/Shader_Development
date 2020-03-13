Shader "Root/RimLighting" {

	Properties {
		_RimColor ("Colour", Color) = (1,1,1,1)
		_RimSlider("Rim Slider", Range(0, 1)) = 0.5
		_RimPower("RimFallOff", float) = 3
	}

	SubShader {
		CGPROGRAM
			#pragma surface surf Lambert
			
			struct Input
			{
				float2 uvMainTex;
				float3 viewDir;
			};

			fixed4 _RimColor;
			float _RimSlider;
			float _RimPower;

			void surf (Input IN, inout SurfaceOutput o)
			{
				half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
				o.Emission = 
					(rim > _RimSlider ? _RimColor.rgb * pow(rim,_RimPower) : fixed3(0,0,0)) 
					* sin(_Time.y + 2);
			}

		ENDCG
	}

	FallBack "Diffuse"
}