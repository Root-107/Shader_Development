Shader "Root/VolumetricFog"
{
    Properties
    {
        _Scale("Scale", Range(0.1, 10)) = 2
        _StepScale("Step Scale", Range(0.1, 100)) = 1
        _Steps("Number of steps", Range(1,200)) = 60
        _MinHight("Min Hight", Range(0, 5)) = 0
        _MaxHight("Max Hight", Range(6, 10)) = 10
        _FadeDistance("Fade Distace", Range(0, 10)) = 5
        _SunDir("Sun Direction", Vector) = (1,0,0,0)

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

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                 float4 pos: SV_POSITION;
                 float3 view : TEXCOORD0;
                 float4 projPos : TEXCOORD1;
                 float3 wpos : TEXCOORD2;
            };

            float _MinHight;
            float _MaxHight;
            float _FadeDistance;
            float _Scale;
            float _StepScale;
            float _Steps;
            float4 _SunDir;
            sampler2D _CameraDepthTexture;

            float random(float3 value, float3 dotDir)
            {
                float3 smallV = sin(value);
                float random = dot(smallV, dotDir);
                random = frac(sin(random) * 1234574.6543);
                return random;
            }

            float3 radom3d(float3 value)
            {
                return float3 (
                    random(value, float3(12.3, 68.53, 37.7)),
                    random(value, float3(39.0, 26.54, 85.3)),
                    random(value, float3(100.8, 10.1, 63.7))
                );
            }

            float noise3D(float3 value)
            {
                value *= _Scale;
                float3 interp = frac(value);
                interp = smoothstep(0,1, interp);

                float3 zValues[2];
                for(int z = 0; z <= 1; z++)
                {
                    float3 yValues[2];
                    for(int y = 0; y <= 1; y++)
                    {
                        float3 xValues[2];
                        for(int x = 0; x <=1; x++)
                        {
                            float3 cell = floor(value) + float3(x,y,z);
                            xValues[x] = radom3d(cell);
                        }

                        yValues[y] = lerp(xValues[0], xValues[1], interp.x);
                    }

                    zValues[z] = lerp(yValues[0], yValues[1], interp.y);
                }

                float noise = -1.0 + 2.0 * lerp(zValues[0], zValues[1], interp);
                return noise;
            }

            fixed4 integrate(fixed4 sum, float diffuse, float density, fixed4 bgcol, float t)
            {
                fixed3 lighting = fixed3(.65, .68, .7) * 1.3 + .5 * fixed3(.7,.5,.3) * diffuse;
                fixed3 colRgb = lerp(fixed3(1,.95,.8), fixed3(.65,.65,.65), density);
                fixed4 col = fixed4(colRgb.r,colRgb.g,colRgb.b, density);
                col.rgb *= lighting;
                col.rgb = lerp(col.rgb, bgcol, 1 - exp(-.003*t*t)); 
                col.a *= 0.5;
                col.rgb *= col.a;
                return sum + col*(1.0 - sum.a);
            }

            #define MARCH(steps, noiseMap, cameraPos, viewDir, bgcol, sum, depth, t) { \
                for(int i = 0; i < steps + 1; i++) \
                { \
                    if(t > depth) \
                    { \
                        break; \
                    } \
                    \
                    float3 pos = cameraPos + t * viewDir; \
                    if(pos.y < _MinHight || pos.y > _MaxHight || sum.a > 0.99) \
                    { \
                        t+= max(.1, .02*t); \
                        continue; \
                    } \
                    \
                    float density = noiseMap(pos); \
                    if(density > .01) \
                    { \
                        float diffuse = clamp((density - noiseMap(pos + 0.3 * _SunDir)) / .6, 0.0, 1); \
                        sum = integrate(sum, diffuse, density, bgcol, t); \
                    } \
                    \
                    t+= max(.1,.02 * t); \
                } \
            }

            #define NOISEPROC(N,P) 1.75 * N * saturate((_MaxHight - P.y) / _FadeDistance)

            float map1(float3 p)
            {
                float3 q = p;
                float f;
                f = 0.5 * noise3D(q);
                //return f;
                return NOISEPROC(f,p);
            }

            fixed4 Raymarch(float3 cameraPos, float3 viewDir, fixed4 bgcol, float depth)
            {
                fixed4 c = fixed4(0,0,0,0);
                //ct keep track of number of steps
                float ct = 0;

                MARCH(_Steps, map1, cameraPos, viewDir, bgcol, c, depth, ct);

                return clamp(c, 0, 1);
            }


            v2f vert (appdata v)
            {
                v2f o;
                o.wpos = mul(unity_ObjectToWorld, v.vertex).xyz;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.view = o.wpos - _WorldSpaceCameraPos;
                o.projPos = ComputeScreenPos(o.pos);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float depth = 1;
                depth *= length(i.view);
                fixed4 c = fixed4(1,1,1,0);
                fixed4 clouds = Raymarch(_WorldSpaceCameraPos, normalize(i.view) * _StepScale, c, depth);
                fixed3 mixedColour = c * (1.0 - clouds.a) + clouds.rgb;
                return fixed4(mixedColour, clouds.a);
            }
            ENDCG
        }
    }
}
