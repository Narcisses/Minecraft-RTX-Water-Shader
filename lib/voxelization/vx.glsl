#include "/lib/voxelization/uv.glsl"

#define MAX_STEP 64
const float VX_VOXEL_SIZE = 100;
const float VX_GRID_SIZE = 8;

uniform sampler2D texture;

struct RayHit {
    bool hit;
    int blockID;
    vec3 position;
    vec4 color;
    vec3 normal;
};

vec2 voxelToTexture(vec3 voxel) {
    float layer = voxel.y;

    vec2 grid = vec2(
        mod(layer, VX_GRID_SIZE),
        floor(layer / VX_GRID_SIZE)
    ) * VX_VOXEL_SIZE;

    return vec2(
        mod(voxel.x, VX_VOXEL_SIZE),
        floor(voxel.z)
    ) + grid;
}

bool voxelWithinBounds(vec3 voxel) {
    if (voxel.x > 0 && voxel.y > 0 && voxel.z > 0) {
        if (voxel.x < VX_VOXEL_SIZE && voxel.y < VX_VOXEL_SIZE && voxel.z < VX_VOXEL_SIZE) {
            return true;
        }
    }
    return false;
}

vec4 sampleColor(vec3 intersection, vec2 samplePoint) {
    vec4 color = vec4(0.0);
    ivec3 cellPosition = ivec3(floor(intersection));
    vec3 cellOffset = intersection - cellPosition;
    float epsilon = 0.001;
    vec2 uv = vec2(0.0);
    vec2 offset = vec2(0.0);

    int faceID = 0;

    if (cellOffset.x <= epsilon) {
        // Left
        faceID = 2;
        offset = vec2(1.0) - cellOffset.zy;
    }

    if (cellOffset.x >= 1.0 - epsilon) {
        // Right
        faceID = 3;
        offset = vec2(1.0) - cellOffset.zy;
    }

    if (cellOffset.y <= epsilon) {
        // Bottom
        faceID = 1;
        offset = cellOffset.xz;
    }

    if (cellOffset.y >= 1.0 - epsilon) {
        // Top
        faceID = 0;
        offset = cellOffset.xz;
    }

    if (cellOffset.z <= epsilon) {
        // Front
        faceID = 4;
        offset = vec2(1.0) - cellOffset.xy;
    }

    if (cellOffset.z >= 1.0 - epsilon) {
        // Back
        faceID = 5;
        offset = vec2(1.0) - cellOffset.xy;
    }

    vec3 biomeColor = texture2DLod(shadowcolor0, samplePoint, 0).rgb;
    float blockID = texture2DLod(shadowcolor0, samplePoint, 0).a;

    uv = getUV(int(blockID) - 10000, faceID);
    uv += offset / vec2(64, 32);
    color = texture2DLod(texture, uv, 0);

    return color;
}

vec3 normalFromHit(vec3 intersection, vec2 samplePoint) {
    vec3 normal = vec3(0.0);
    ivec3 cellPosition = ivec3(floor(intersection));
    vec3 cellOffset = intersection - cellPosition;
    float epsilon = 0.001;

    if (cellOffset.x <= epsilon) {
        // Left
        normal = vec3(-1.0, 0.0, 0.0);
    }

    if (cellOffset.x >= 1.0 - epsilon) {
        // Right
        normal = vec3(1.0, 0.0, 0.0);
    }

    if (cellOffset.y <= epsilon) {
        // Bottom
        normal = vec3(0.0, -1.0, 0.0);
    }

    if (cellOffset.y >= 1.0 - epsilon) {
        // Top
        normal = vec3(0.0, 1.0, 0.0);
    }

    if (cellOffset.z <= epsilon) {
        // Front
        normal = vec3(0.0, 0.0, 1.0);
    }

    if (cellOffset.z >= 1.0 - epsilon) {
        // Back
        normal = vec3(0.0, 0.0, -1.0);
    }

    return normal;
}

RayHit voxelTrace(vec3 o, vec3 d) {
    vec3 cameraOffset = fract(cameraPosition);
    o += cameraOffset;

    float dx = abs(1.0 / d.x);
    float dy = abs(1.0 / d.y);
    float dz = abs(1.0 / d.z);

    vec3 vRayUnitStepSize = vec3(dx, dy, dz);
    ivec3 vMapCheck = ivec3(floor(o));
    vec3 vRayLength1D = vec3(0.0);
    ivec3 vStep = ivec3(0);

    if (d.x < 0) {
        vStep.x = -1;
        vRayLength1D.x = (o.x - float(vMapCheck.x)) * vRayUnitStepSize.x;
    }
    else {
        vStep.x = 1;
        vRayLength1D.x = (float(vMapCheck.x + 1) - o.x) * vRayUnitStepSize.x;
    }

    if (d.y < 0) {
        vStep.y = -1;
        vRayLength1D.y = (o.y - float(vMapCheck.y)) * vRayUnitStepSize.y;
    }
    else {
        vStep.y = 1;
        vRayLength1D.y = (float(vMapCheck.y + 1) - o.y) * vRayUnitStepSize.y;
    }

    if (d.z < 0) {
        vStep.z = -1;
        vRayLength1D.z = (o.z - float(vMapCheck.z)) * vRayUnitStepSize.z;
    }
    else {
        vStep.z = 1;
        vRayLength1D.z = (float(vMapCheck.z + 1) - o.z) * vRayUnitStepSize.z;
    }

    ivec3 map_pos = ivec3(floor(o));
    float fDistance = 0.0;
    int i = 0;

    while (i < MAX_STEP) {
        vec3 centered_voxel = map_pos + vec3(VX_VOXEL_SIZE / 2.0);
        vec2 samplePoint = voxelToTexture(centered_voxel - vec3(0, 0, 1)) / shadowMapResolution;
        // Make the sample point be at the exact center of the pixel (manual linear filtering cancelation)
        samplePoint = (floor(samplePoint * shadowMapResolution) + vec2(0.5)) / shadowMapResolution;

        if (voxelWithinBounds(centered_voxel) && isWithinTex(samplePoint)) {
            if (texture2D(shadow, samplePoint).r < 0.7) {
                float e = 0.0001;
                vec3 intersection = o + d * (vec3(fDistance) + vec3(e));
                vec4 color = sampleColor(intersection, samplePoint);

                // Continue tracing if transparent part
                if (color.a > 0.5) {
                    vec3 normal = normalFromHit(intersection, samplePoint);
                    vec3 hitpos = o + d * vec3(fDistance) - cameraOffset;
                    int blockID = int(texture2D(shadowcolor0, samplePoint).a);

                    return RayHit(true, blockID, hitpos, color, normal);
                }
            }
        } else {
            break;
        }

        // Walk along shortest path
        if (vRayLength1D.x < vRayLength1D.y && vRayLength1D.x < vRayLength1D.z) {
            vMapCheck.x += vStep.x;
            fDistance = vRayLength1D.x;
            vRayLength1D.x += vRayUnitStepSize.x;
        }
        
        else if (vRayLength1D.y < vRayLength1D.x && vRayLength1D.y < vRayLength1D.z) {
            vMapCheck.y += vStep.y;
            fDistance = vRayLength1D.y;
            vRayLength1D.y += vRayUnitStepSize.y;
        }

        else {
            vMapCheck.z += vStep.z;
            fDistance = vRayLength1D.z;
            vRayLength1D.z += vRayUnitStepSize.z;
        }

        ivec3 cell = ivec3(floor(o + d * (vec3(fDistance) + vec3(0.01))));
        map_pos = cell;
        i += 1;
    }

    
    return RayHit(false, -1, vec3(0.0), vec4(0.0), vec3(0.0));
}