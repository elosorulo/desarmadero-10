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
	vec2 st = gl_FragCoord.xy/u_resolution;

	float composicion_a = cuadrada(st.x * rampa(u_time) * 10.);
	
	composicion_a = composicion_a * sin(st.y * 10.) * st.x;
	
	composicion_a = rampa(composicion_a * dentada(st.x * cuadrada(2. * u_time)));

	float composicion_b = rampa(rampa(st.y) * 10. * st.y * cuadrada(st.x * u_time));

	gl_FragColor = vec4(vec3(composicion_b + composicion_a, composicion_b, composicion_a * composicion_b), 1.);
}
