Shader "Yoshioka/RenderToTexture"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        //Cull Off ZWrite Off ZTest Always

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
                float4 vertex : SV_POSITION;
                float4 color : TEXCOORD0;
            };

            sampler2D _MainTex;

            v2f vert (appdata v)
            {
                v2f o;
                float4 cal = tex2Dlod(_MainTex, float4(v.uv, 0, 0));
                //o.vertex = UnityObjectToClipPos(v.vertex);
                o.vertex = float4(cal.xy * 2 - 1, 1, 1.0);
                o.color = cal.z;
                o.color.w = cal.w;
                return o;
            }

            float4 frag (v2f i) : SV_Target
            {
                return i.color;
            }
            ENDCG
        }
    }
}
