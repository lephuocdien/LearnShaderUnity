
Shader "Custom/DiffuseWhite"
{   
    SubShader {
        Tags { "RenderType"="Opaque" }      
        CGPROGRAM
        #pragma surface surf Lambert
        struct Input {

               float4 color:COLOR; 
        };
        void surf(Input IN,inout SurfaceOutput  o) {
          o.Albedo=(0,1,1,1);
        }
        ENDCG
    } 
    Fallback "Diffuse"
}
