
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

float f1(vec2 st) {
	
	float x1 = smoothstep(0.2, 0.8, st.x * sin(PI * u_time));

	float x2 = fract(st.y * 10.);

	return distance(x1, x2);
}


void main() {

	vec2 st = fract(gl_FragCoord.xy/u_resolution);

	
	float n1 = noise(st);

	float forma = f1(vec2(step(fract(distance(0.5 + st * n1, vec2(0.5)) * -14. * st.x), st.x)) - st * distance(st * st.y * step(0.9, log(0.5 + st.y)), vec2(sin(u_time))));

	vec3 color = vec3(distance(vec2(st.y* st.y,st.x* n1), st)/ st.x - forma * n1 * st.y / sin(u_time), forma  - f1(n1 * st * st.y * sin(u_time * PI)), forma) ;

	gl_FragColor = vec4(color * distance(log(color.y) * color.x, n1), 1.);
}
