Shader "Seb/ReferenceShader"
{
    //Properties are shows in the inspector. 
    //WARNING: Defining a property is not enough, you have to define a variable in the shader code with the same name.
    Properties
    {
        _Color1 ("Color1", Color) = (1,0,0,1)
        _Color2 ("Color2", Color) = (0,1,0,1)
    }
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

            float4 _Color1;
            float4 _Color2;

            struct MeshData //Per vertex mesh data
            {
                float4 vertex : POSITION; //Vertex position
            };

            struct Interpolators //Data passed from the vertex shader to the fragment shader
            {
                float4 vertex : SV_POSITION; //Clip space position
            };

            Interpolators vert (MeshData v)
            {
                Interpolators o;
                o.vertex = v.vertex;//Local space to clip space
                return o;
            }

            float4 frag (Interpolators i) : SV_Target //The SV semantics says that this should output to the frame buffer in most cases
            {
                float4 col = lerp(_Color1, _Color2, i.vertex.x);
                return col;
            }
            ENDCG
        }
    }
} 
