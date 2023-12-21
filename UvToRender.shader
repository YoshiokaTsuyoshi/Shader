Shader "Yoshioka/UvToTexture"
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
            //#pragma target 3.5

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float3 normal : TEXCOORD1;
            };

            struct target
            {
                float4 display : COLOR0;
                float4 uvtotex : COLOR1;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                o.uv = v.uv;
                //fault program
                //int temp = step(1, abs(o.vertex.x / o.vertex.w)) + step(1, abs(o.vertex.y / o.vertex.w));
                //o.vertex.xy = temp * (v.uv * 2 - 1) * o.vertex.w + (1 - min(temp, 1)) * o.vertex.xy;
                return o;
            }

            target frag (v2f i)
            {
                target o;
                o.display = 1;
                o.uvtotex = float4(i.uv, dot(i.normal, _WorldSpaceCameraPos), 1);
                return o;
            }
            ENDCG
        }
    }
}
