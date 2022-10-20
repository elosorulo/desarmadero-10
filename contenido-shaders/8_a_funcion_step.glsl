#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#define PI 3.1415926535

void main() {
	vec2 st = gl_FragCoord.xy/u_resolution;

	float alpha = step(0.5, st.x);

	gl_FragColor = vec4(vec3(alpha), 1.);
}
