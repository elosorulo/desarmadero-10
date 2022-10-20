#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#define PI 3.1415926535

float triangular(float x) {

	x = abs(x);
	
	return abs((x - 2. * floor(x/2.)) - 1.);
}

float rampa(float x) {
	return abs(fract(x));
}

float dentada(float x) {
	return -abs(fract(x)) + 1.;
}
	
float cuadrada(float x) {
	return step(0.5, fract(x));
}

float senoidal(float x) {
	return fract(sin(fract(x) * PI));
}

void main() {
	vec2 st = gl_FragCoord.xy/u_resolution;

	float composicion_a = rampa(senoidal(st.y * senoidal(st.x * 10.)) * 2.);
	
	gl_FragColor = vec4(vec3(composicion_a), 1.);
}
