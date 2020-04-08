Shader "Root/CustomLightingModel" {
	Properties{
		_MainTex("Main", 2D) = "white" {}
	}

		SubShader{
			CGPROGRAM
				#pragma surface surf BasicLambert

				sampler2D _MainTex;

				struct Input
				{
					float2 uv_MainTex;
				};

				float4 LightingBasicLambert(SurfaceOutput s, half3 lightDir, half atten)
				{
					/* 
					NormalDotLight value = dot product returns a value of 1 when directly over the surface
					*/
					half NdotL = dot (s.Normal, lightDir);
					float4 c;
					c.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten);
					c.a = s.Alpha;
					return c;
				}


				void surf(Input IN, inout SurfaceOutput o)
				{
					o.Albedo = (0.8,0.8,0.8);
				}

			ENDCG
		}

			FallBack "Diffuse"
}