Shader "Seb/NormalsAsColor"
{
    //Properties are shows in the inspector. 
    //WARNING: Defining a property is not enough, you have to define a variable in the shader code with the same name.
 
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

            float _Value;

            struct MeshData //Per vertex mesh data
            {
                float4 vertex : POSITION; //Vertex position
                float4 normal : NORMAL; //Vertex normal
                float2 uv0 : TEXCOORD0; //uv coordinates
            };

            struct Interpolators //Data passed from the vertex shader to the fragment shader
            {
                float4 vertex : SV_POSITION; //Clip space position
                float2 uv : TEXCOORD0; //In this case TEXCOORD0 does NOT refer to UV channels
                float4 normal : TEXCOORD1; //Normal
            };


            Interpolators vert (MeshData v)
            {
                Interpolators o;
                o.normal = v.normal;
                o.vertex = UnityObjectToClipPos(v.vertex);//Local space to clip space
                return o;
            }

            //Final function that returns the color of the pixel to the screen
            //fixed4 is just a float4 with less precision (no platform ever uses it anymore)

            // float (32 bit float) Kind of overkill, but good to use as default unless targetting lower end hardware or optimizing
            // half (16 bit float) Pretty good for most things
            // fixed (lower precision float) -1 to 1 (no platform ever uses it anymore)


            float4 frag (Interpolators i) : SV_Target //The SV semantics says that this should output to the frame buffer in most cases
            {
                float4 col = float4 (i.normal.x, i.normal.y, i.normal.z, i.normal.w);
                return col;
            }
            ENDCG
        }
    }
} 
