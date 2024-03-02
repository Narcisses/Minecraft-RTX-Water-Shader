/* shadow texture */
const int shadowMapResolution = 1024;

const bool shadowcolor0Mipmap = false;
const bool shadowcolor0Nearest = false;
const bool shadowHardwareFiltering = false;
const bool shadowHardwareFiltering0 = false;
const bool shadow0MinMagNearest = true;
const bool shadowColor0MinMagNearest = true;
const bool shadowColor1MinMagNearest = true;
const int superSamplingLevel = 0;

/* viewport */
uniform float viewWidth;
uniform float viewHeight;
uniform float aspectRatio;

/* clipping plane */
uniform float far;
uniform float near;

/* Noise & frame counter */
uniform sampler2D noisetex;
uniform int frameCounter;

/* buffer settings
const int colortex0Format = RGBA32F;
const int colortex1Format = RGBA32F;
const int colortex2Format = RGBA32F;
const int colortex3Format = RGBA32F;
const int colortex4Format = RGBA32F;
const int colortex5Format = RGBA32F;
const int colortex6Format = RGBA32F;
const int colortex7Format = RGBA32F;
const int colortex8Format = RGBA32F;

const int shadowcolor0Format = RGBA32F;
const int shadowcolor1Format = RGBA32F;
const int shadowcolor2Format = RGBA32F;
const int shadowcolor3Format = RGBA32F;
const int shadowcolor4Format = RGBA32F;
const int shadowcolor5Format = RGBA32F;
const int shadowcolor6Format = RGBA32F;
const int shadowcolor7Format = RGBA32F;

const int shadowBuffer0Format = RGBA32F;
const int shadowBuffer1Format = RGBA32F;
const int shadowBuffer2Format = RGBA32F;
const int shadowBuffer3Format = RGBA32F;
const int shadowBuffer4Format = RGBA32F;
const int shadowBuffer5Format = RGBA32F;
const int shadowBuffer6Format = RGBA32F;
const int shadowBuffer7Format = RGBA32F;

const int gcolorFormat = RGB16;
const int gdepthFormat = R16;
const int gnormalFormat = RGB8;
const int compositeFormat = RGBA32F;
const int gaux1Format = RGB32F;
const bool gcolorClear = false;
const bool compositeClear = false;
const int noiseTextureResolution = 256;
const float ambientOcclusionLevel = 0.0;
*/

/* samplers */
uniform sampler2D gcolor;
uniform sampler2D gdepth;
uniform sampler2D gnormal;
uniform sampler2D lightmap;
uniform sampler2D composite;

uniform sampler2D colortex0;
uniform sampler2D colortex1;
uniform sampler2D colortex2;
uniform sampler2D colortex3;
uniform sampler2D colortex4;
uniform sampler2D colortex5;
uniform sampler2D colortex6;
uniform sampler2D colortex7;
uniform sampler2D colortex8;

uniform sampler2D shadow;
uniform sampler2D shadowcolor0;
uniform sampler2D shadowcolor1;
uniform sampler2D shadowcolor2;
uniform sampler2D shadowcolor3;
uniform sampler2D shadowcolor4;
uniform sampler2D shadowcolor5;
uniform sampler2D shadowcolor6;
uniform sampler2D shadowcolor7;

/* camera pos */
uniform vec3 cameraPosition;
uniform vec3 previousCameraPosition;

/* time */
uniform int worldTime;

/* sun & moon */
uniform vec3 sunPosition;
uniform vec3 moonPosition;
const float sunPathRotation = -0.0;

/* matrices */
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferProjectionInverse;

/* RTX variables */
const int MAX_BOUNCE = 2;

/* util functions */
float linearDepth(float depth) { return (2.0 * near) / (far + near - depth * (far - near)); }
float encodeDepth(float depth) { return depth / far; }
float decodeDepth(float depth) { return depth * far; }
vec3 encodeNormal(vec3 normal) { return (normal + 1.0) / 2.0; }
vec3 decodeNormal(vec3 normal) { return (normal * 2.0) - 1.0; }

/* transforms */
bool isWithinTex(vec2 texcoord) {
    return texcoord.x > 0.0 && texcoord.x < 1.0 && texcoord.y > 0.0 && texcoord.y < 1.0;
}

vec3 getWorldPos(vec2 coord, float depth) {
    vec4 pos = vec4(vec3(coord, depth) * 2.0 - 1.0, 1.0);
	pos = gbufferModelViewInverse * pos;
	return pos.xyz;
}

vec3 getViewDir(vec2 coord) {
    coord.x *= aspectRatio;
    coord.x -= (aspectRatio - 1.0) / 2.0;
    return normalize(getWorldPos(coord, 0.074));
}

vec3 hemisphere(float yaw, float pitch, vec3 normal) {
    float normalYaw = atan(normal.y, normal.x);
    float normalPitch = -asin(normal.z);

    normalYaw += yaw * 1.57079632679;
    normalPitch += pitch * 1.57079632679;

    return vec3(
        cos(normalYaw) * cos(normalPitch),
        sin(normalYaw) * cos(normalPitch),
        sin(normalPitch)
    );
}

float rand(vec2 co){
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

vec3 brdf(vec3 direction, vec3 normal, float roughness) {
    vec3 reflected = reflect(direction, normal);
    vec2 noise = (vec2(
        rand(texcoord + 0.451),
        rand(texcoord + 0.251)
    ) - 0.5f) * 2.0;
    vec3 randomHemisphere = hemisphere(noise.x, noise.y, normal);

    return normalize(mix(reflected, randomHemisphere, roughness));
}

/* poisson disc */
const vec2 Poisson64[64] = vec2[](
    vec2(-0.934812, 0.366741),
    vec2(-0.918943, -0.0941496),
    vec2(-0.873226, 0.62389),
    vec2(-0.8352, 0.937803),
    vec2(-0.822138, -0.281655),
    vec2(-0.812983, 0.10416),
    vec2(-0.786126, -0.767632),
    vec2(-0.739494, -0.535813),
    vec2(-0.681692, 0.284707),
    vec2(-0.61742, -0.234535),
    vec2(-0.601184, 0.562426),
    vec2(-0.607105, 0.847591),
    vec2(-0.581835, -0.00485244),
    vec2(-0.554247, -0.771111),
    vec2(-0.483383, -0.976928),
    vec2(-0.476669, -0.395672),
    vec2(-0.439802, 0.362407),
    vec2(-0.409772, -0.175695),
    vec2(-0.367534, 0.102451),
    vec2(-0.35313, 0.58153),
    vec2(-0.341594, -0.737541),
    vec2(-0.275979, 0.981567),
    vec2(-0.230811, 0.305094),
    vec2(-0.221656, 0.751152),
    vec2(-0.214393, -0.0592364),
    vec2(-0.204932, -0.483566),
    vec2(-0.183569, -0.266274),
    vec2(-0.123936, -0.754448),
    vec2(-0.0859096, 0.118625),
    vec2(-0.0610675, 0.460555),
    vec2(-0.0234687, -0.962523),
    vec2(-0.00485244, -0.373394),
    vec2(0.0213324, 0.760247),
    vec2(0.0359813, -0.0834071),
    vec2(0.0877407, -0.730766),
    vec2(0.14597, 0.281045),
    vec2(0.18186, -0.529649),
    vec2(0.188208, -0.289529),
    vec2(0.212928, 0.063509),
    vec2(0.23661, 0.566027),
    vec2(0.266579, 0.867061),
    vec2(0.320597, -0.883358),
    vec2(0.353557, 0.322733),
    vec2(0.404157, -0.651479),
    vec2(0.410443, -0.413068),
    vec2(0.413556, 0.123325),
    vec2(0.46556, -0.176183),
    vec2(0.49266, 0.55388),
    vec2(0.506333, 0.876888),
    vec2(0.535875, -0.885556),
    vec2(0.615894, 0.0703452),
    vec2(0.637135, -0.637623),
    vec2(0.677236, -0.174291),
    vec2(0.67626, 0.7116),
    vec2(0.686331, -0.389935),
    vec2(0.691031, 0.330729),
    vec2(0.715629, 0.999939),
    vec2(0.8493, -0.0485549),
    vec2(0.863582, -0.85229),
    vec2(0.890622, 0.850581),
    vec2(0.898068, 0.633778),
    vec2(0.92053, -0.355693),
    vec2(0.933348, -0.62981),
    vec2(0.95294, 0.156896)
);
