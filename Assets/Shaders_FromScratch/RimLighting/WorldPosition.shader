﻿Shader "Root/WorldPos" {
	Properties {
		_Snow("Snow", Color) = (1,1,1,1)
		_Grass("Grass", Color) = (1,1,1,1)
		_Sea("Sea", Color) = (1,1,1,1)
	}

	SubShader {
		CGPROGRAM
			#pragma surface surf Lambert
			
			struct Input
			{
				float2 uvMainTex;
				float3 worldPos;
			};

			fixed4 _Snow;
			fixed4 _Sea;
			fixed4 _Grass;

			void surf (Input IN, inout SurfaceOutput o)
			{
				float posY = IN.worldPos.y;
				o.Albedo = posY > 1 ? _Snow.rgb : posY < 0 ? _Sea.rgb : _Grass.rgb;
				
			}

		ENDCG
	}

	FallBack "Diffuse"
}