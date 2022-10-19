#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#define PI 3.1415926535

void main() {

	vec2 st = fract(gl_FragCoord.xy/u_resolution * 10.);

	float borde = (1. + sin(u_time)) * 0.2;

	float izq = step(borde, st.x);
	float der = 1.- step(1. - borde, st.x);
	float arriba = step(borde, st.y);
	float abajo = smoothstep(1. - borde, 1. - borde * 0.2, st.y);

	float circulo = distance(vec2(0.5), st);

	float cuadrado = izq * der * arriba * abajo;
	float alpha = circulo * cuadrado;

	gl_FragColor = vec4(vec3(alpha), 1.);
}
