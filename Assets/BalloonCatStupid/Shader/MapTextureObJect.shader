Shader "CustomLD/MapTextureObJect"
{
    Properties
    {
       _MainTex("Texture",2D)="white"{}
    }
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
            sampler2D _MainTex;   
            fixed4 frag(v2f i):SV_TARGET
            {
                fixed4 col = tex2D(_MainTex,i.uv);
                return col;
                
            }  
            ENDCG
        }
    }
}
