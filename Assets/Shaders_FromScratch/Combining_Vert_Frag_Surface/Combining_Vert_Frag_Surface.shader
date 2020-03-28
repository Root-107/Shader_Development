Shader "Root/Combining_Vert_Frag_Surface"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Slider("Slider", Range(-0.5,0.5)) = 0.1
    }
    SubShader
    {

        CGPROGRAM
        #pragma surface surf Lambert vertex:vert

        sampler2D _MainTex;
        float _Slider;

        struct Input
        {
            float2 uv_MainTex;
        };

        struct appdata 
        {
            float4 vertex: POSITION;
            float3 normal: NORMAL;
            float4 texcoord: TEXCOORD0;
        };

        void vert(inout appdata v)
        {
            v.vertex.xyz += v.normal * _Slider;
        }

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
