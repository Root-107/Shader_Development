Shader "Root/ColourByVertexFrag"
{
    Properties
    {
       
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float4 color: COLOR;
            };

            //mesh positions/objct lcoal positions
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                //o.color.r = (v.vertex.x / 5);
                //o.color.g = (v.vertex.z / 5);
                //o.color.b = (v.vertex.y / 5);
                return o;
            }

            //screen space positions
            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = i.color;
                //fixed4 col;
                //col.r = i.vertex.x/1920;
                //col.b = i.vertex.y/1920;
                return col;
            }
            ENDCG
        }
    }
}
