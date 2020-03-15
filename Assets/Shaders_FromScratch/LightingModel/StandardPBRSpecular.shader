Shader "Root/StandardPBRSpecular" {
	Properties{
		_MainTex("Main", 2D) = "white" {}
		_MetalicTex("Metalic Texture", 2D) = "white" {}
		_SpecColor("Spec Colour", Color) = (1,1,1,1)
	}

		SubShader{
			CGPROGRAM
				#pragma surface surf StandardSpecular

				struct Input
				{
					float2 uv_MainTex;
				};

				sampler2D _MainTex;
				sampler2D _MetalicTex;

				void surf(Input IN, inout SurfaceOutputStandardSpecular o)
				{
					o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
					o.Smoothness = tex2D(_MetalicTex, IN.uv_MainTex).r;
					o.Specular = _SpecColor.rgb;

				}

			ENDCG
		}

			FallBack "Diffuse"
}