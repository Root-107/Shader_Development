Shader "Root/BasicBlinn" {
	Properties {
		_MainTex("Main", 2D) = "white" {}

		_SpecColor("Spec Colour", Color) = (1,1,1,1)
		_Spec("Specular power", Range(0,1)) = 0.5
		_Gloss("Gloss", Range(0,1)) = 0.5
	}

	SubShader {
		CGPROGRAM
			#pragma surface surf BlinnPhong
			
			struct Input
			{
				float2 uv_MainTex;
			};

			sampler2D _MainTex;
			half _Spec;
			fixed _Gloss;

			void surf (Input IN, inout SurfaceOutput o)
			{
				o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
				o.Specular = _Spec;
				o.Gloss = _Gloss;
			}

		ENDCG
	}

	FallBack "Diffuse"
}