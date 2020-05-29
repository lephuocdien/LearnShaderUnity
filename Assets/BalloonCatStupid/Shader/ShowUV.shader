Shader "Unlit/ShowUV"
{
   
    SubShader
    { 
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag     
            struct appdata
            {
                float4 pos :POSITION;
                float2 uv : TEXCOORD0;

            };
            struct v2f
            {
                float4 pos:SV_POSITION;
                float2 uv :TEXCOORD0;
            };
            v2f  vert(appdata input)
            {
                v2f o;
                o.uv=input.uv;
                o.pos=UnityObjectToClipPos(input.pos);

                return o;

            }
            struct fragOutput
            {
                float4 color :SV_TARGET;

            };         
            fragOutput frag(v2f i):SV_TARGET
            {
                fragOutput o;
                o.color= fixed4(i.uv,0,0);
                return o;
                
            }  
            ENDCG
        }
    }
}
