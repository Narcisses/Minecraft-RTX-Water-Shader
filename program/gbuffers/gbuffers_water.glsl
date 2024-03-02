#include "/lib/voxelization/common.glsl"

varying vec3 fragPos;
varying vec2 texcoord;
varying vec2 lmcoord;
varying vec3 color;
varying vec3 normal;

#ifdef VSH

void main() {
    fragPos = gl_Vertex.xyz;
    gl_Position = ftransform();
    texcoord = gl_MultiTexCoord0.xy;
    lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
    color = gl_Color.rgb;
    normal = gl_Normal;
}

#endif

#ifdef FSH

#include "/lib/water/water.glsl"
#include "/lib/voxelization/vx.glsl"

void main() {
    /* RENDERTARGETS: 0,7*/
    vec4 waterColor = WATER_COLOR;
    vec3 viewDir = normalize(fragPos);
    vec3 waterNormal = normal;
    vec3 viewReflect = reflect(viewDir, waterNormal);
    RayHit hit = voxelTrace(fragPos, viewReflect);

    vec4 finalColor = waterColor;

    if (hit.hit) {
        vec4 reflectionColor = hit.color;
        float fresnel = dot(-viewDir, waterNormal);
        fresnel = pow(fresnel, 2);
        fresnel = clamp(fresnel, 0.0, 1);
        finalColor = mix(reflectionColor, waterColor, fresnel);
    }    
    finalColor *= texture2D(lightmap, lmcoord);

    gl_FragData[0] = finalColor;
}

#endif
