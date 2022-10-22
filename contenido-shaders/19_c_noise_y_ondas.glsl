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

float rand(vec2 n) { 
	return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 43758.5453);
}

float noise(vec2 p){
	vec2 ip = floor(p);
	vec2 u = fract(p);
	u = u*u*(3.0-2.0*u);
	
	float res = mix(
		mix(rand(ip),rand(ip+vec2(1.0,0.0)),u.x),
		mix(rand(ip+vec2(0.0,1.0)),rand(ip+vec2(1.0,1.0)),u.x),u.y);
	return res*res;
}

float rectangulo(vec2 uv, float i, float d, float ar, float ab) {
	float izq = step(i, uv.x);
	float der = 1.- step(1. - d, uv.x);
	float arriba = step(ar, uv.y);
	float abajo = step(ab, uv.y);
	
	return izq * der * arriba * abajo;
}

float circulo(vec2 st, float radio) {
	return step(radio, (distance(st, vec2(0.5))));
}

void main() {

	vec2 uv = fract(gl_FragCoord.xy/u_resolution);
	
	float rojo = rampa(dentada(uv.y * 80. * (0.9 + 0.1 * senoidal(u_time))) * noise(uv * 10.) * uv.x * 10.);

	float verde = 0.5 * senoidal(uv.y * noise(uv * 10.));

	float azul =  senoidal(uv.y * u_time) * triangular(uv.x * noise(uv) * 10.);

	gl_FragColor = vec4(rojo, verde, azul, 1.);
}
