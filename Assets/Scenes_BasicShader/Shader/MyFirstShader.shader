// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/MyFirstShader"
{
    Properties
    {
        _Tint("Tint",Color)=(1,1,1,1)
        _MainTex("Texture",2D)="white"
        _Angle("Angle",float)=1
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex MyVertexProgram
            #pragma fragment MyFragmentProgram
            #include "UnityCG.cginc"
            float4 _Tint;
            sampler2D _MainTex;
            float _Angle;      
            struct Interpolators 
            {
                float4 position : SV_POSITION;
                float2 uv : TEXCOORD0;               
            };
            struct VertexData 
            {
               
				float4 position : POSITION;
				float2 uv : TEXCOORD0;
			};
            float RotateAroundYInDegrees(float4 vertex, float degrees)
            {
                float alpha = degrees * UNITY_PI / 180.0;
                float sina, cosa;
                sincos(alpha, sina, cosa);
                float2x2 m = float2x2(cosa, -sina, sina, cosa);
                return float4(mul(m, vertex.xz), vertex.yw).xzyw;

            }
            Interpolators MyVertexProgram(VertexData v)
            {
                Interpolators i;      
              //  v.position = RotateAroundYInDegrees(v.position,_Angle);        
                i.position = UnityObjectToClipPos(v.position);
                i.uv = v.uv ;
                return i;

            }
            float4 MyFragmentProgram(Interpolators i):SV_TARGET
            {
               // return float4(i.uv,1,1) ;
               return tex2D(_MainTex,i.uv) *_Tint;

            }

            ENDCG
        
        }       
    }
}
