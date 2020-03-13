Shader "Root/NormalMapping" {

	Properties {
		_MainTex("Diffuse", 2D) = "white" {}
		_Normal("Normal Map", 2D) = "white" {}
		_NormalIntensity("NormalIntensity", Range(-5, 5)) = 0
	}

	SubShader {
		CGPROGRAM
			#pragma surface surf Lambert
			
			struct Input
			{
				float2 uv_MainTex;
			};

			sampler2D _MainTex;
			sampler2D _Normal;
			float _NormalIntensity;

			void surf (Input IN, inout SurfaceOutput o)
			{
				o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
				o.Normal = UnpackNormal(tex2D(_Normal, IN.uv_MainTex));
				o.Normal *= float3(_NormalIntensity, _NormalIntensity, 1);
			}

		ENDCG
	}

	FallBack "Diffuse"
}