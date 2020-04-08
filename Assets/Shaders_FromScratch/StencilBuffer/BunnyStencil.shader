Shader "Root/BunnyStencil" {
	Properties{
		_MainTex("Main", 2D) = "white" {}
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

				void surf(Input IN, inout SurfaceOutputStandard o)
				{
					fixed4 c;
					c = tex2D(_MainTex, IN.uv_MainTex);
					o.Albedo = c.rgb;
				}

			ENDCG
		}

			FallBack "Diffuse"
}