#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#define PI 3.1415926535

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

	vec2 st = fract(gl_FragCoord.xy/u_resolution * 10.);

	float borde = (1. + sin(u_time)) * 0.2;

	float izq = step(borde, st.x);
	float der = 1.- step(1. - borde, st.x);
	float arriba = step(borde, st.y);
	float abajo = 1. - step(1. - borde, st.y);
	float alpha = izq * der * arriba * abajo;

	gl_FragColor = vec4(vec3(alpha), 1.);
}
