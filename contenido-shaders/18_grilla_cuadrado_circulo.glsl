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

float rectangulo(vec2 st, float i, float d, float ar, float ab) {
	float izq = step(i, st.x);
	float der = 1.- step(1. - d, st.x);
	float arriba = step(ar, st.y);
	float abajo = step(ab, st.y);
	
	return izq * der * arriba * abajo;
}

float circulo(vec2 st, float radio) {
	return step(radio, (distance(st, vec2(0.5))));
}

void main() {

	vec2 st = fract(gl_FragCoord.xy/u_resolution);

	st = vec2(rampa(dentada(dentada(2. * u_time)) * rampa(st.x / u_time)+ st.x * 4.), dentada(senoidal(st.y * 4.) * dentada(u_time) * 3.));

	float dibujo = st.x / distance(st.y, dentada(st.y / st.x)) * circulo(st, distance(st.y, dentada(10. * st.x)));

	gl_FragColor = vec4(vec3(dibujo), 1.);
}
