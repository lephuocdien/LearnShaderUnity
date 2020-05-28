Shader "Custom/RedColorShader"
{
    Properties
    {
      
    }
    SubShader
    {
       

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct VertexInput
            {
                float4 pos:POSITION;
            };
            struct VertexOut
            {
                float4 pos:SV_POSITION;
            }; 
            VertexOut vert(VertexInput i)
            {
                VertexOut o;
                o.pos=UnityObjectToClipPos(i.pos);
                return o;
            }
            half4 frag(VertexOut o) :COLOR 
            {
                return half4(1.0, 1.0, 0.0, 1.0); 

            }
       
            ENDCG
        }
    }
}
