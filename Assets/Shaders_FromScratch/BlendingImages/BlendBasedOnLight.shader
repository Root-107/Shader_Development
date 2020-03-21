Shader "Root/BlendBasedOnLight" {

	Properties {
	_BaseColor("Colour", Color) = (1,1,1,1)
		_MainTex("Diffuse", 2D) = "white" {}
		_DecalTex("Decal", 2D) = "white" {}
	}

	SubShader {
		CGPROGRAM
			#pragma surface surf Blend
			
			struct Input
			{
				float2 uv_MainTex;
				float2 uv_DecalTex;
				float3 worldFefl;
			};

			sampler2D _MainTex;
			sampler2D _DecalTex;
			fixed4 _BaseColor;

			float4 LightingBlend(SurfaceOutput s, fixed3 lightDir, fixed atten)
			{
				float diff = dot(s.Normal, lightDir);
				float h = diff * 0.5 + 0.5;
				float2 rh = h;
				float3 main = tex2D(_MainTex, rh).rgb;
				float3 decal = tex2D(_DecalTex, rh).rgb;

				float4 c;
				c.rgb = h > 0.5? main.rgb : decal.rgb;
				c.a = s.Alpha;
				return c;
			}

			void surf (Input IN, inout SurfaceOutput o)
			{
				o.Albedo = _BaseColor.rgb;
			}

		ENDCG
	}

	FallBack "Diffuse"
}