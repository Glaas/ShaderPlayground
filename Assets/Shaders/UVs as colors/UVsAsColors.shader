Shader "Seb/UVsAsColors"
{
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM
            //Those pragma statements define the name of the vertex shader and fragment shader functions
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct MeshData //Per vertex mesh data
            {
                float4 vertex : POSITION; //Vertex position
                float2 uv0 : TEXCOORD0; //uv coordinates
            };

            struct Interpolators //Data passed from the vertex shader to the fragment shader
            {
                float4 vertex : SV_POSITION; //Clip space position
                float2 uv : TEXCOORD0; //In this case TEXCOORD0 does NOT refer to UV channels
            };

            Interpolators vert (MeshData v)
            {
                Interpolators o;
                o.uv = v.uv0;
                o.vertex = UnityObjectToClipPos(v.vertex);//Local space to clip space
                return o;
            }

            float4 frag (Interpolators i) : SV_Target //The SV semantics says that this should output to the frame buffer in most cases
            {
                float4 col = float4 (i.uv.x, i.uv.y, 0, 1); //This is the color of the pixel
                return col;
            }
            ENDCG
        }
    }
} 
