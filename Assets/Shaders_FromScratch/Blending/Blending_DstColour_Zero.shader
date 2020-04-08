Shader "Root/Blending_DstColour_Zero" {

	Properties {
		_MainTex("Main Texture", 2D) = "black" {}
	}

	SubShader {
		Tags {"Queue" = "Transparent"}

		Blend DstColor Zero

		Pass{
			SetTexture [_MainTex] {combine texture}
		}

		//CGPROGRAM
		//	#pragma surface surf Lambert
			

		//	struct Input
		//	{
		//		float2 uv_MainTex;
		//	};

		//	sampler2D _MainTex;

		//	void surf (Input IN, inout SurfaceOutput o)
		//	{
		//		fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
		//		o.Albedo = tex.rgb;
		//	}

		//ENDCG
	}

	FallBack "Diffuse"
}