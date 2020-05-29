Shader "CustomLD/VertexID"
{
    
    SubShader
    {
       

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.5
            struct v2f
            {
                float4 pos:POSITION;
                float4 color :TEXCOORD0;

            };           
            v2f vert(float4 vertex:POSITION,uint vid : SV_VertexID)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(vertex);
                float f = (float)vid;
                if(f%12==0)
                    o.color = half4(1,0,1,1);
                else
                    o.color =half4(1,0,0,1);
                return o;

            }
            fixed4 frag (v2f i) : SV_Target
            {
                return i.color;
            }
            ENDCG
        }
    }
}
