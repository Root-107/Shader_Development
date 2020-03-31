Shader "Root/Ray_MarchSphere"
{
    Properties
    {
        _ObjectPos("Object Position", Vector) = (1,1,1,1)
        _Radius("Sphere radius", float) = 0.5
    }

    SubShader
    {
        Tags { "Queue"="Transparent" }

        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "UnityLightingCommon.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float3 wPos : TEXCOORD0;
                float4 pos : SV_POSITION;
            };

            float4 _ObjectPos;
            float _Radius;

            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.wPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                return o;
            }

            #define STEPS 128
            #define STEP_SIZE 0.01

            bool SphereHit(float3 pos, float3 center)
            {
                return distance(pos, center) < _Radius;
            }

            float3 RaymarchHit(float3 position, float3 direction)
            {
                for(int i = 0; i < STEPS; i++)
                {
                    if(SphereHit(position, _ObjectPos.xyz))
                    {
                        return position;
                    }

                    position += direction * STEP_SIZE;
                }

                return float3(0,0,0);
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float3 viewDirection = normalize(i.wPos - _WorldSpaceCameraPos);
                float3 worldPos = i.wPos;
                float3 depth = RaymarchHit(worldPos, viewDirection);

                half3 worldNormal = depth - _ObjectPos;
                half nl = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz));

                fixed4 c;

                if(length(depth) != 0)
                {
                    depth*= nl * _LightColor0 * 2;
                    c = fixed4(depth, 1);
                }else{
                    c = fixed4(1,1,1,0);
                }

                return c;
            }
            ENDCG
        }
    }
}
