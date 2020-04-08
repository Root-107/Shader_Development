Shader "Root/TextureBlending" {

	Properties {
		_MainTex("Diffuse", 2D) = "white" {}
		_DecalTex("Decal", 2D) = "white" {}
	}

	SubShader {
		CGPROGRAM
			#pragma surface surf Lambert
			
			struct Input
			{
				float2 uv_MainTex;
				float2 uv_DecalTex;
			};

			sampler2D _MainTex;
			sampler2D _DecalTex;

			void surf (Input IN, inout SurfaceOutput o)
			{
				fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
				fixed4 decal = tex2D(_DecalTex, IN.uv_DecalTex);
				c.rgb = lerp (c.rgb, decal.rgb, decal.a);
				o.Albedo = c.rgb;
			}

		ENDCG
	}

	FallBack "Diffuse"
}