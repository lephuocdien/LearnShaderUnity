Shader "UnlitLD/GrabShader"
{
   
    SubShader
    {
        Tags { "Queue"="Transparent"}    
        GrabPass{"_GrabTexture"}   
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            sampler2D _GrabTexture;

            struct appdata
            {
                float4 vertex : POSITION;
                
            };

            struct v2f
            {
                float4 vertex :POSITION;
                float4 uvgrab :TEXCOORD1;
            };

           

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uvgrab = ComputeGrabScreenPos(o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(i.uvgrab));
                return  col + half4(0.5,0.05,0.0,0);
            }
            ENDCG
        }
    }
}
