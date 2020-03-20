Shader "Custom/Hologram"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _RimColor("Rim Colour", Color) = (1,1,1,1)
        _RimColor2("Rim color 2", Color) = (1,1,1,1)
        _RimPower("Rim Power", Range(0,10)) = 3.0
    }
    SubShader
    {
        Tags { "Queue"="Transparent" }

        //Remove and add this pass to see a different effect
        //this writes to the zbuffer to alow for a transparent 
        //shader that culls the stuff the other side of the pixel that is facing the view
        Pass {
            Zwrite On
            ColorMask 0
        }

        CGPROGRAM
        #pragma surface surf Lambert alpha:fade

        sampler2D _MainTex;
        float _RimPower;
        fixed4 _RimColor;
        fixed4 _RimColor2;


        struct Input
        {
            float2 uv_MainTex;
            float3 viewDir;
            float3 worldNormal;
        };


        void surf (Input IN, inout SurfaceOutput o)
        {
            half rim = 1.0 - saturate(dot (normalize(IN.viewDir), o.Normal));
            float rimPower = pow (rim, _RimPower);

            fixed4 c;
            c = tex2D(_MainTex, (IN.worldNormal.y + (_Time*0.1)) * 2);


            o.Emission = c * ((c.r < 0.1? _RimColor2.rgb : _RimColor.rgb) * rimPower * 10);
            o.Emission = c * ((c.r < 0.1? _RimColor2.rgb : _RimColor.rgb) * rimPower * 10);
            o.Alpha = rimPower;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
