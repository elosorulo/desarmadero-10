#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#define PI 3.1415926535

float circulo(float radio, vec2 uv) {
	return 1.- step(radio, distance(vec2(0.5), uv));
}

void main() {
	vec2 uv = gl_FragCoord.xy/u_resolution;

	float grilla = circulo(0.25,fract(uv * 10.));

	gl_FragColor = vec4(vec3(grilla), 1.);
}
