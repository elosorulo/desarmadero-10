#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#define PI 3.1415926535

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

	
	gl_FragColor = vec4(vec3(noise(uv * 100.)), 1.);
}
