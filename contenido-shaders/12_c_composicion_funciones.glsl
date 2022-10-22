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

void main() {
	vec2 uv = gl_FragCoord.xy/u_resolution;

	float composicion_a = cuadrada(uv.x * rampa(u_time) * 10.);
	
	composicion_a = composicion_a * sin(uv.y * 10.) * uv.x;
	
	composicion_a = rampa(composicion_a * dentada(uv.x * cuadrada(2. * u_time)));

	float composicion_b = rampa(rampa(uv.y) * 10. * uv.y * cuadrada(uv.x * u_time));

	gl_FragColor = vec4(vec3(composicion_b + composicion_a, composicion_b, composicion_a * composicion_b), 1.);
}
