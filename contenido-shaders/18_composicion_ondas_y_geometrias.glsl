#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#define PI 3.1415926535


float senoidal(float x) {
	return (1. + sin(x * PI)) / 2.;
}

float rampa(float x) {
	return fract(x);
}

float dentada(float x) {
	return 1. - fract(x);
}

float cuadrada(float x) {
	return step(0.5, fract(x));
}

float triangular(float x) {

	x = abs(x);
	
	return abs((x - 2. * floor(x/2.)) - 1.);
}

float circulo(vec2 uv, float radio) {
	return step(radio, (distance(uv, vec2(0.5))));
}

void main() {

	vec2 uv = fract(gl_FragCoord.xy/u_resolution);

	float rojo = dentada(uv.y * 100. * senoidal(u_time)) * distance(rampa(senoidal(40. + u_time) * uv.x * 15.), circulo(uv, 0.25));

	gl_FragColor = vec4(rojo, 0., .2, 1.);
}
