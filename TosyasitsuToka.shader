Shader "Unlit/TosyasitsuToka"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        //_MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        CGINCLUDE
        #pragma vertex vert
        #pragma fragment frag

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
            float3 position : TEXCOORD2;
        };

        half4 _Color;

        v2f vert (appdata v)
        {
            v2f o;
            o.vertex = UnityObjectToClipPos(v.vertex);
            o.uv = v.uv;
            o.normal = UnityObjectToWorldNormal(v.normal);
            o.position = mul(unity_ObjectToWorld, v.vertex);
            return o;
        }
        ENDCG

        Pass
        {
            Tags {"LightMode"="ForwardAdd"}
            CGPROGRAM
            fixed4 frag (v2f i) : SV_Target
            {
                clip(dot(i.normal, normalize(float3(0, 0, 0) - i.position)) - 0.1);
                fixed4 col = _Color;
                return col;
            }
            ENDCG
        }
    }
}