#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#define PI 3.1415926535

float cuadrada(float x) {
	return step(0.5, fract(x));
}

void main() {
	vec2 uv = gl_FragCoord.xy/u_resolution;

	float rojo = cuadrada(uv.x * 10.);

	gl_FragColor = vec4(rojo, 0., 0., 1.);
}
