Shader "Root/Wave"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Foam("Foam", 2D) = "white" {}
        _Tint("Tint Colour", Color) = (1,1,1,1)
        _Freq("Frequency", Range(0,8)) = 2.5
        _Speed("Speed", Range(0,100)) = 10
        _Amp("Amplitude", Range(0,1)) = 0.5

        _ScroleWaterX("Scrole X", float) = 1
        _ScroleWaterY("Scrole Y", float) = 1
        _FoamScroleX("Foam Scrole X", float) = 1
        _FoamScroleY("Foam Scrole Y", float) = 1
    }

    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert vertex:vert

        struct Input {
            float2 uv_MainTex;
            float3 vertColor;
        };

        float4 _Tint;
        float _Freq;
        float _Speed;
        float _Amp;

        struct appdata{
          float4 vertex: POSITION;
          float3 normal: NORMAL;
          float4 texcoord: TEXCOORD0;
          float4 texcoord1: TEXCOORD1;
          float4 texcoord2: TEXCOORD2;
        };

        void vert (inout appdata v, out Input o){
            UNITY_INITIALIZE_OUTPUT(Input, o);
            float t = _Time * _Speed;
            float t2 = _Time * _Speed + 3;
            float waveHeight = (sin(t + v.vertex.x * _Freq) * _Amp
            + (sin(t2 + v.vertex.y * _Freq + 1) * _Amp));

            v.vertex.z = waveHeight;

            v.normal = normalize(float3(v.normal.x + waveHeight, v.normal.y, v.normal.z));
            o.vertColor = waveHeight + 0.4;
        }

        sampler2D _MainTex;
        sampler2D _Foam;
        float _FoamScroleX;
        float _FoamScroleY;
        float _ScroleWaterX;
        float _ScroleWaterY;

        void surf (Input IN, inout SurfaceOutput o){

            _FoamScroleX*= _Time;
            _FoamScroleY*= _Time;

            _ScroleWaterX *= _Time;
            _ScroleWaterY *= _Time;

            float2 uv_foam = IN.uv_MainTex + float2( _FoamScroleX, _FoamScroleY);

            float4 c = tex2D(_MainTex, IN.uv_MainTex + float2(_ScroleWaterX, _ScroleWaterY));

            float4 foam = tex2D(_Foam, uv_foam); 
            c += lerp(c, foam, foam.a * IN.vertColor.r);
            o.Albedo = c * (IN.vertColor.rgb);
        }

        ENDCG
    }
}
