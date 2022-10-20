
#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#define PI 3.1415926535

float triangular(float x) {

	x = abs(x);
	
	return abs((x - 2. * floor(x/2.)) - 1.);
}

void main() {
	vec2 st = gl_FragCoord.xy/u_resolution;

	float alpha = triangular(st.x * 10.);

	gl_FragColor = vec4(vec3(alpha), 1.);
}
