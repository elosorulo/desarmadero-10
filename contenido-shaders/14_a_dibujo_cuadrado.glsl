#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#define PI 3.1415926535

void main() {
	vec2 uv = gl_FragCoord.xy/u_resolution;

	float izq = step(0.2, uv.x);
	float der = 1.- step(0.8, uv.x);
	float arriba = step(0.2, uv.y);
	float abajo = 1. - step(0.8, uv.y);
	float alpha = izq * der * arriba * abajo;

	gl_FragColor = vec4(vec3(alpha), 1.);
}
