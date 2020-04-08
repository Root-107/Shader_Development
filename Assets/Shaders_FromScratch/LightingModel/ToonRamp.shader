Shader "Root/ToonRamp" {

	Properties {
		_colour ("Colour", Color) = (1,1,1,1)
		_Ramp("Ramp texture", 2D) = "white" {}
	}

	SubShader {
		CGPROGRAM
			#pragma surface surf Toon
			
			fixed4 _colour;
			sampler2D _Ramp;

			struct Input
			{
				float2 uv_MainTex;
			};

			float4 LightingToon(SurfaceOutput s, fixed3 lightDir, fixed atten)
			{
				/*
				Calcualte the dot product between 0-1
				use that as UV coords to determin where on the ramp this shows
				top right is 1, bottom left is 0

				if dotp is 1, then (1 * 0.5) + 0.5 = 1, so top right.
				if dotp is -1 then "maths" = 0, so bottom left
				*/
				float diff = dot(s.Normal, lightDir);
				float h = diff * 0.5 + 0.5;
				float2 rh = h;
				float3 ramp = tex2D(_Ramp, rh).rgb;

				float4 c;
				c.rgb = s.Albedo * _LightColor0.rgb * (ramp);
				c.a = s.Alpha;
				return c;
			}


			void surf (Input IN, inout SurfaceOutput o)
			{
				o.Albedo = _colour.rgb;
			}

		ENDCG
	}

	FallBack "Diffuse"
}