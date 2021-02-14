Shader "Custom/PhongRim"
{
    Properties
    {
        _Albedo("Albedo", Color) = (1, 1, 1, 1)
        [HDR] _EmissionColor("EmissionColor", Color) = (1, 1, 1, 1)
        _RimPower("Rim Power", Range(0.0, 8.0)) = 1.0
    }

    SubShader
{
     Tags
        {
            "Queue" = "Geometry"
            "RenderType" = "Opaque"
        } 

        CGPROGRAM

        #pragma surface surf Lambert

        
        half4 _Albedo;
        float4 _EmissionColor;
        float _RimPower;

        struct Input
        {
            float3 viewDir;
        };

        
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _Albedo;
            float3 viewDirNormalized= normalize(IN.viewDir);
            float VdotN = dot(viewDirNormalized, o.Normal);
            fixed rim = 1 - saturate(VdotN);
            o.Emission = _EmissionColor * pow(rim, _RimPower);
        }

        ENDCG
}

}

