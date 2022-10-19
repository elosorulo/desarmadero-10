#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#define PI 3.1415926535

void main() {
	vec2 st = gl_FragCoord.xy/u_resolution;

	float color = abs(sin(u_time * PI)) * st.x;

	gl_FragColor = vec4(vec3(color), 1.);
}
