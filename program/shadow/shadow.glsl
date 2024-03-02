#include "/lib/voxelization/common.glsl"

#ifdef VSH

attribute vec3 mc_Entity;

out vec3 worldPos;
out vec3 normal;
out vec4 gshColor;
out vec2 gshTexCoord;
out vec3 entity;

void main() {
    worldPos = gl_Vertex.xyz;
    normal = gl_Normal;
    gshColor = gl_Color;
    gshTexCoord = gl_MultiTexCoord0.xy;
    entity = mc_Entity;
}

#endif

#ifdef GSH

#include "/lib/voxelization/vx.glsl"

layout(triangles) in;
layout(points, max_vertices = 1) out;

in vec3 worldPos[];
in vec3 normal[];
in vec4 gshColor[];
in vec2 gshTexCoord[];
in vec3 entity[];

out vec3 biomeColor;
flat out float blockID;

void main() {
    if (int(entity[0].x + 0.5) >= 10000) {
        vec3 triNormal = normalize(cross(worldPos[1] - worldPos[0], worldPos[2] - worldPos[0]));
        vec3 triCentroid = (worldPos[0] + worldPos[1] + worldPos[2]) / 3.0;
        vec3 withinVoxel = triCentroid + fract(cameraPosition) - triNormal * 0.1;
        vec3 roundedVoxel = floor(withinVoxel);
        vec3 centeredVoxel = roundedVoxel + floor(vec3(VX_VOXEL_SIZE / 2.0));

        if (voxelWithinBounds(centeredVoxel)) {
            vec2 uv = voxelToTexture(centeredVoxel) / (shadowMapResolution / 2.0) - vec2(1.0);
            gl_Position = vec4(uv, 0.0, 1.0);

            blockID = int(entity[0].x + 0.5);
            biomeColor = ((gshColor[0] + gshColor[1] + gshColor[2]) / 3.0).rgb;

            EmitVertex();
            EndPrimitive();
        }
    }
}

#endif

#ifdef FSH

in vec3 biomeColor;
flat in float blockID;

void main() {
    /*RENDERTARGETS: 0*/
    gl_FragData[0] = vec4(vec3(biomeColor), blockID);
}

#endif
