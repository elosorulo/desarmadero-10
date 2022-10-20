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

	vec2 st = fract(gl_FragCoord.xy/u_resolution);

	st = st* vec2(sin(st.x), sin(st.y));

	st = vec2(dentada(st.x * 10.), dentada(st.y * 10.));

	float borde = (.34 + sin(u_time)) * 0.;

	float izq = step(borde, st.x);
	float der = 1.- step(1. - borde, st.x);
	float arriba = step(borde, st.y);
	float abajo = 1. - step(1. - borde, st.y);
	float alpha = izq * der * arriba * abajo;

	alpha = alpha * .5 * dentada(st.y * sin(u_time) + sin(u_time) * st.x * cuadrada(st.y * 12. * sin(u_time)));

	alpha += rampa(10. * dentada(u_time * 18.)) * .2;

	gl_FragColor = vec4(vec3(dentada(st.x * 4. * sin(u_time)) + alpha * dentada(40. * distance(st.x * cuadrada(st.y), st.y - dentada(u_time))), alpha, alpha * dentada(st.x)), 1.);
}
