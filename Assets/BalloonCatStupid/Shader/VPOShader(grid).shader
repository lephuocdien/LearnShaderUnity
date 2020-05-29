Shader "Unlit/VPOShader(grid)"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
       
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.0
            struct v2f
            {
                float2 uv:TECOORD0;
            };
            v2f vert(float4 pos:POSITION,float2 uv:TEXCOORD,out float4 output :SV_POSITION)
            {
                v2f o;
                o.uv=uv;
                output=UnityObjectToClipPos(pos);
                return o;
            }
            sampler2D _MainTex;
            fixed4 frag(v2f i,UNITY_VPOS_TYPE screenPos : VPOS) : SV_Target
            {
                screenPos.xy = floor(screenPos.xy * 0.25) * 0.5;
                float checker = -frac(screenPos.r + screenPos.g);

                // clip HLSL instruction stops rendering a pixel if value is negative
                clip(checker);

                // for pixels that were kept, read the texture and output it
                fixed4 c = tex2D (_MainTex, i.uv);
                return c;
            }
            ENDCG
        }
    }
}
