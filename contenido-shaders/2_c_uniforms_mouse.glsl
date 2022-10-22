#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#define PI 3.1415926535

void main() {
	vec2 uv = gl_FragCoord.xy/u_resolution;

	vec2 uvMouse = u_mouse / u_resolution;

	gl_FragColor = vec4(uv.x, 0., 1. * uvMouse.x, 1.);
}
