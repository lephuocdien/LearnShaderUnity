Shader "CustomLD/SingleColor"
{
    Properties
    {
        _Color("Color",Color)=(1,0,1,1)
    }
    SubShader
    {
        

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            float4 vert(float4 pos:POSITION):SV_POSITION
            {
                return UnityObjectToClipPos(pos);

            }
            float4 _Color;
            fixed4 frag():SV_TARGET
            {
                return  _Color;
            }
            ENDCG
        }
    }
}
