#include "/lib/voxelization/common.glsl"

varying vec2 texcoord;

#ifdef VSH

void main() {
    texcoord = gl_MultiTexCoord0.xy;
    gl_Position = ftransform();
}

#endif

#ifdef FSH

#include "/lib/water/water.glsl"
#include "/lib/voxelization/vx.glsl"

void main() {
    /*RENDERTARGETS: 0*/
    vec3 color = texture2D(gcolor, texcoord).rgb;
    gl_FragData[0] = vec4(color, 1.0);
}

#endif
