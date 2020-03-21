Shader "Root/CutOutHole" {
	Properties{
		_MainTex("Main", 2D) = "white" {}
	}

	SubShader 
	{
		//we want this to render before the geometry
		Tags {"Queue" ="Geometry-1"}

		ColorMask 0
		ZWrite off

		Stencil
		{
			Ref 1
			Comp always
			Pass replace
		}

		CGPROGRAM
			#pragma surface surf Lambert

			struct Input
			{
				float2 uv_MainTex;
			};

			sampler2D _MainTex;

			void surf(Input IN, inout SurfaceOutput o)
			{
				o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
			}

		ENDCG
	}

	FallBack "Diffuse"
}