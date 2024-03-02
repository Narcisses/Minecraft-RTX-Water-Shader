#include "/lib/voxelization/common.glsl"

varying vec2 texcoord;

#ifdef VSH

void main() {
    texcoord = gl_MultiTexCoord0.xy;
    gl_Position = ftransform();
}

#endif

#ifdef FSH

void main() {
    vec4 color = texture2D(gcolor, texcoord);

    // // Reinhard tone mapping
    // float exposure = 1.0;
    // vec3 mapped = color.rgb / (color.rgb + vec3(exposure));

    // // gamma correction
    // float gamma = 2.2;
    // mapped = pow(mapped, vec3(1.0 / gamma));

    vec3 mapped = color.rgb;

    gl_FragData[0] = vec4(mapped, color.a);
}

#endif
