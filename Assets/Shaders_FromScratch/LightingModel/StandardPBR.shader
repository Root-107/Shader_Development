Shader "Root/StandardPBR" {
	Properties{
		_MainTex("Main", 2D) = "white" {}
		_MetalicTex("Metalic Texture", 2D) = "white" {}
		_Metalic("Metalic", Range(0,1)) = 1
	}

		SubShader{
			CGPROGRAM
				#pragma surface surf Standard

				struct Input
				{
					float2 uv_MainTex;
				};

				sampler2D _MainTex;
				sampler2D _MetalicTex;
				half _Metalic;

				void surf(Input IN, inout SurfaceOutputStandard o)
				{
					o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
					o.Smoothness = tex2D(_MetalicTex, IN.uv_MainTex);
					o.Metallic = _Metalic;

				}

			ENDCG
		}

			FallBack "Diffuse"
}