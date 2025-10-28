#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 v0_in[];
layout(location = 1) in vec4 v1_in[];
layout(location = 2) in vec4 v2_in[];
layout(location = 3) in vec4 up_in[];

layout(location = 0) out float v_height;

out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    vec4 v0 = v0_in[0];
    vec4 v1 = v1_in[0];
    vec4 v2 = v2_in[0];
    vec3 up = normalize(up_in[0].xyz);

    float orientation = v0.w;
    float height = v1.w;
    float width = v2.w;

    vec3 forward = vec3(cos(orientation), 0.0, sin(orientation));
    vec3 right = normalize(cross(up, forward));

    vec3 p = pow(1.0 - v, 2.0) * v0.xyz +
             2.0 * (1.0 - v) * v * v1.xyz +
             pow(v, 2.0) * v2.xyz;

    float halfWidth = width * 0.5 * (1.0 - v);
    vec3 offset = right * (u - 0.5) * 2.0 * halfWidth;
    vec3 worldPos = p + offset;

    vec4 viewPos = camera.view * vec4(worldPos, 1.0);
    gl_Position = camera.proj * viewPos;

    v_height = v;
}
