
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

float f1(vec2 uv) {
	
	float x1 = smoothstep(0.2, 0.8, uv.x * sin(PI * u_time));

	float x2 = fract(uv.y * 10.);

	return distance(x1, x2);
}


void main() {

	vec2 uv = fract(gl_FragCoord.xy/u_resolution);

	
	float n1 = noise(uv);

	float forma = f1(vec2(step(fract(distance(0.5 + uv * n1, vec2(0.5)) * -14. * uv.x), uv.x)) - uv * distance(uv * uv.y * step(0.9, log(0.5 + uv.y)), vec2(sin(u_time))));

	vec3 color = vec3(distance(vec2(uv.y* uv.y,uv.x* n1), uv)/ uv.x - forma * n1 * uv.y / sin(u_time), forma  - f1(n1 * uv * uv.y * sin(u_time * PI)), forma) ;

	gl_FragColor = vec4(color * distance(log(color.y) * color.x, n1), 1.);
}
