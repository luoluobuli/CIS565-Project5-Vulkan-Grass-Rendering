
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs
layout(location = 0) in vec4 v0_in;
layout(location = 1) in vec4 v1_in;
layout(location = 2) in vec4 v2_in;
layout(location = 3) in vec4 up_in;

out gl_PerVertex {
    vec4 gl_Position;
};

layout(location = 0) out vec4 v0_out;
layout(location = 1) out vec4 v1_out;
layout(location = 2) out vec4 v2_out;
layout(location = 3) out vec4 up_out;

void main() {
	// TODO: Write gl_Position and any other shader outputs
    v0_out = model * vec4(v0_in.xyz, 1.0);
    v1_out = model * vec4(v1_in.xyz, 1.0);
    v2_out = model * vec4(v2_in.xyz, 1.0);
    up_out.xyz = normalize(mat3(model) * up_in.xyz);

    v0_out.w = v0_in.w;
    v1_out.w = v1_in.w;
    v2_out.w = v2_in.w;
    up_out.w = up_in.w;

    gl_Position = v0_out; // placeholder
}
