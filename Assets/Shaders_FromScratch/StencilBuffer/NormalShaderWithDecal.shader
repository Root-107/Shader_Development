Shader "Root/NormalWithDecal" {
	Properties{
		_MainTex("Main", 2D) = "white" {}
		_Decal("Decal", 2D) = "white" {}
		_MetalicTex("Metalic Texture", 2D) = "white" {}
		_NormalMap("Normal map", 2D) = "white" {}
		_NormalIntensity("Normal Power", Range(-5,5)) = 1
		_Metalic("Metalic", Range(0,1)) = 1
	}

		SubShader{

			Stencil
			{
				Ref 1
				Comp notequal
				Pass keep
			}

			CGPROGRAM
				#pragma surface surf Standard

				struct Input
				{
					float2 uv_MainTex;
				};

				sampler2D _MainTex;
				sampler2D _Decal;
				sampler2D _MetalicTex;
				sampler2D _NormalMap;
				float _NormalIntensity;
				half _Metalic;

				void surf(Input IN, inout SurfaceOutputStandard o)
				{
					fixed4 c;
					c = tex2D(_MainTex, IN.uv_MainTex);
					fixed4 decal = tex2D(_Decal, IN.uv_MainTex);
					o.Smoothness = tex2D(_MetalicTex, IN.uv_MainTex);
					o.Metallic = _Metalic;
					o.Normal = UnpackNormal(tex2D(_NormalMap, IN.uv_MainTex));
					o.Normal *= float3(_NormalIntensity, _NormalIntensity, 1);
					o.Albedo = lerp(c.rgb, decal.rgb, decal.a);
				}

			ENDCG
		}

			FallBack "Diffuse"
}