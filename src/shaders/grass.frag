#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in float inHeight;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
    vec3 base = vec3(0.11, 0.388, 0.102);
    vec3 tip  = vec3(0.725, 1, 0.267);
    vec3 color = mix(base, tip, inHeight);

    outColor = vec4(color, 1.0);
}
