#ifdef GL_ES
precision mediump float;
#endif

uniform float u_time;

#define PI 3.1415926535

void main() {
	
	vec3 color = vec3(sin(u_time * PI * 3.));

	gl_FragColor = vec4(color, 1.);
}
