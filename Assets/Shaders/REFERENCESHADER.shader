Shader "Unlit/FirstUnlitShader"
{
    //Properties are shows in the inspector. 
    //WARNING: Defining a property is not enough, you have to define a variable in the shader code with the same name.
    Properties
    {
        _Value ("Value", Float) = 0.0
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

            float _Value;

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

            sampler2D _MainTex;
            float4 _MainTex_ST;

            Interpolators vert (MeshData v)
            {
                Interpolators o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv0, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (Interpolators i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}
