#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#define PI 3.1415926535

void main() {
	vec2 st = gl_FragCoord.xy/u_resolution;


	float alpha = 1.- step((1. + sin(u_time)) * 0.25,distance(vec2(0.5), fract(st * 10.)));

	gl_FragColor = vec4(vec3(alpha), 1.);
}
