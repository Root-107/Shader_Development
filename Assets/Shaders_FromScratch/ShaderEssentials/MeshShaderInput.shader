Shader "Root/ShaderInput" {

	Properties {
		_colour ("Colour", Color) = (1,1,1,1)
		_emission("Emmission", Color) = (1,1,1,1)
		_range("Range", Range(0,5)) = 1
		_MainTex("Main Texture", 2D) = "white" {}
		_emissionMap("Main Texture", 2D) = "white" {}
		_cubeMap("Cube", CUBE) = "" {}
		_float("float", Float) = 0.5
		_vector("Vector", Vector) = (0.5, 1, 1, 1)
	}

	SubShader {
		CGPROGRAM
			#pragma surface surf Lambert
			
			struct Input
			{
				float2 uv_MainTex;
				//float2 uv2_MainTex;
				//float3 viewDir; //from view angle
				//float3 worldPos; //cords of vertext being processed
				float3 worldRefl; //reflection data
			};

			fixed4 _colour;
			fixed4 _emission;
			half _range;
			sampler2D _MainTex;
			sampler2D _emissionMap;
			samplerCUBE _cubeMap;
			float _float;
			float4 _vector;

			void surf (Input IN, inout SurfaceOutput o)
			{
				float4 main = tex2D(_MainTex, IN.uv_MainTex);
				o.Albedo = _colour.rgb;
				o.Albedo += main.rgb;

				o.Emission = tex2D(_emissionMap, IN.uv_MainTex) * _range;

				//reflection
				fixed4 cube = texCUBE(_cubeMap, IN.worldRefl); 
				o.Albedo += cube.rgb;
				o.Emission += cube.rgb;
			}

		ENDCG
	}

	FallBack "Diffuse"
}