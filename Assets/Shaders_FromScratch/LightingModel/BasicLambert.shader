Shader "Root/BasicLambert" {
	Properties {
		_MainTex("Main", 2D) = "white" {}
	}

	SubShader {
		CGPROGRAM
			#pragma surface surf BlinnPhong
			
			struct Input
			{
				float2 uv_MainTex;
			};

			sampler2D _MainTex;

			void surf (Input IN, inout SurfaceOutput o)
			{
				o.Albedo = tex2D(_MainTex, IN.uv_MainTex);

			}

		ENDCG
	}

	FallBack "Diffuse"
}