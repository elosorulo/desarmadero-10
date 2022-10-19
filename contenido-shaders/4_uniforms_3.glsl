#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#define PI 3.1415926535

void main() {
	vec2 st = gl_FragCoord.xy/u_resolution;

	vec2 mouse_st = u_mouse / u_resolution;

	vec3 colorA = vec3(0.4, 0.2, .4);
	vec3 colorB = vec3(0.2, 0.9, 0.2);

	float color = st.x / mouse_st.x;

	gl_FragColor = vec4(vec3(color), 1.);
}
