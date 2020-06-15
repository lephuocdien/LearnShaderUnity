Shader "Custom/DistortionFlow"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        [NoScaleOffset] _FlowMap ("Flow (RG)",2D)="black"{}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200
        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows
        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0
  

        float3 FlowUVW(float2 uv, float2 flowVector, float time,bool phaseB)
        {
            float phaseA = phaseB ? 0.5 : 0;
            float progress = frac(time+ phaseA);
            float3 uvw;
            
            uvw.xy= uv - flowVector * progress ;
            uvw.z = 1 - abs(1 - 2 * progress);
            return uvw;
        }

    
      
        sampler2D _MainTex,_FlowMap;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_FlowMap;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            
            float2 flowVector = tex2D(_FlowMap, IN.uv_FlowMap).rg * 2 - 1;
            float alpha = tex2D(_FlowMap, IN.uv_FlowMap).a;
            float ttime = alpha + _Time.x;


            float3 uvwA = FlowUVW(IN.uv_MainTex, flowVector, ttime,false);
            float3 uvwB = FlowUVW(IN.uv_MainTex, flowVector, ttime, true);
        
            fixed4 texA = tex2D(_MainTex, uvwA.xy) * uvwA.z;
            fixed4 texB = tex2D(_MainTex, uvwB.xy) * uvwB.z;

            fixed4 c = (texA+ texB) * _Color;
            o.Albedo = c.rgb;

            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
