Shader "Root/NormalMapping_Reflections" {

	Properties {
		_MainTex("Diffuse", 2D) = "white" {}
		_Normal("Normal Map", 2D) = "white" {}
		_NormalIntensity("NormalIntensity", Range(-5, 5)) = 0
		_Environment("Environment", CUBE) = "white" {}
	}

	SubShader {
		CGPROGRAM
			#pragma surface surf Lambert
			
			struct Input
			{
				float2 uv_MainTex;
				float2 uv_Normal;
				float3 worldRefl; INTERNAL_DATA
			};

			sampler2D _MainTex;
			sampler2D _Normal;
			float _NormalIntensity;
			samplerCUBE _Environment;

			void surf (Input IN, inout SurfaceOutput o)
			{
				o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
				o.Normal = UnpackNormal(tex2D(_Normal, IN.uv_Normal));
				o.Normal *= float3(_NormalIntensity, _NormalIntensity, 1);
				o.Emission = texCUBE(_Environment, WorldReflectionVector (IN, o.Normal)).rgb;
			}

		ENDCG
	}

	FallBack "Diffuse"
}