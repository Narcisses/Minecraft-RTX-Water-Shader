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

void main() {
    /* RENDERTARGETS: 0*/
    gl_FragData[0] = texture2D(gcolor, texcoord) * vec4(color, 1.0) * texture2D(lightmap, lmcoord);
}

#endif
