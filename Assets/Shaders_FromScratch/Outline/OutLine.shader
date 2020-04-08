Shader "Root/Outline"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _OutlineColor("OUtline Colour", Color) = (0,0,1,1)
        _Outline("Outline size", Range(0, 0.5)) = 0.1
    }

    SubShader
    {
        ZWrite off
        CGPROGRAM
        #pragma surface surf Lambert vertex:vert

        float _Outline;
        fixed4 _OutlineColor;

        struct Input
        {
            float2 uv_MainTex;
        };

        void vert(inout appdata_full v)
        {
            v.vertex.xyz += v.normal * _Outline;
        }

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Emission = _OutlineColor.rgb;
        }
        ENDCG
        ZWrite on
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
