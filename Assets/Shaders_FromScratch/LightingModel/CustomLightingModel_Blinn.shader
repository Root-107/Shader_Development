Shader "Root/CustomLightingBlinn" {
	Properties{
		_MainTex("Main", 2D) = "white" {}
	}

		SubShader{
			CGPROGRAM
				#pragma surface surf BasicBlinn

				sampler2D _MainTex;

				struct Input
				{
					float2 uv_MainTex;
				};

				half4 LightingBasicBlinn(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
				{
					half3 h = normalize(lightDir + viewDir);
					half diff = max (0, dot(s.Normal, lightDir));

					float nh = max (0, dot(s.Normal, h));
					float spec = pow(nh, 48.0);

					half4 c;
					c.rgb = (s.Albedo * _LightColor0.rgb * diff + _LightColor0.rgb * spec) * atten;
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