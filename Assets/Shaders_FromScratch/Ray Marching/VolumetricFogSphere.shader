Shader "Root/VolumetricFogSphere"
{
    Properties
    {
        _FogCenter("Fog Center/Radius", Vector) = (0,0,0,.5)
        _FogColour("Colour", Color) = (1,1,1,1)
        _InnerRation("Inner Ration", Range(0,1)) = 0.5
        _Dencity("Dencity", Range(0, 1)) = 0.5
    }

    SubShader
    {
        Tags { "Queue"="Transparent" }

        Blend SrcAlpha OneMinusSrcAlpha

        Cull Off Lighting Off ZWrite Off
        ZTest Always 

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            float CalculateFogIntensity(
                float3 center, 
                float radius, 
                float innerRatio, 
                float density, 
                float3 camPos, 
                float3 viewDir, 
                float maxDistance)
            {
                //calculation ray-speahr intersections
                float3 localCam = camPos - center ;
                float a = dot(viewDir, viewDir); //a= D^2
                float b = 2 * dot(viewDir, localCam); // b = 2* camera*D
                float c = dot(localCam, localCam) - radius * radius; //camera^2 - R^2

                // calculate the disgriminant, if its 0 then it missed the spherer
                float d = b * b - 4 * a * c; 

                if(d <= 0){
                    return 0;
                }
                
                float DSqrt = sqrt(d);
                float dist = max((-b -DSqrt)/2*a, 0); // fist hit point
                float dist2 = max((-b +DSqrt)/2*a, 0); // last hit point

                float backDepth = min(maxDistance, dist2);

                float step_amount = 10;

                float sample = dist;
                float step_distance = (backDepth - dist)/step_amount;
                float step_contribution = density;

                float centerValue = 1/(1-innerRatio);

                float clarity = 1;

                for(int seg = 0; seg < step_amount; seg++)
                {
                    float3 position = localCam + viewDir * sample;
                    float val = saturate(centerValue * (1-length(position)/radius));
                    float fog_amount = saturate(val * step_contribution);
                    clarity *= (1-fog_amount);
                    sample += step_distance;
                }

                return 1- clarity;
            }

            struct v2f
            {
                float3 view : TEXCOORD0;
                float4 pos : SV_POSITION;
                float4 projPos : TEXCOORD1;
            };

            float4 _FogCenter;
            fixed4 _FogColour;
            float _InnerRation;
            float _Dencity;

            sampler2D _CameraDepthTexture;

            v2f vert (appdata_base v)
            {
                v2f o;
                float4 wPos = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos(v.vertex);
                o.view = wPos.xyz - _WorldSpaceCameraPos;
                o.projPos = ComputeScreenPos(o.pos);
                
                float inFrontOf = (o.pos.z/o.pos.w) > 0;
                o.pos.z *= inFrontOf;

                return o;
            }


            fixed4 frag (v2f i) : SV_Target
            {
                half4 c = half4(1,1,1,1) ;
                float depth = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD (i.projPos))));
                float3 viewDir = normalize(i.view);
                
                float fog = CalculateFogIntensity(_FogCenter.xyz, _FogCenter.w, _InnerRation, _Dencity, _WorldSpaceCameraPos, viewDir, depth);

                c.rgb = _FogColour.rgb;
                c.a = fog;
                return c;
            }
            ENDCG
        }
    }
}
