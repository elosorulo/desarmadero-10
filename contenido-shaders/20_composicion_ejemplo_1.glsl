#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#define PI 3.1415926535

void main() {

	vec2 uv = fract(gl_FragCoord.xy/u_resolution);

	float x1 = sin(pow(u_time, 1.4)) * uv.y;

	float x2 = fract(pow(uv.x, 2.) * 10.);

	float alpha = distance(x1, fract(log(x2) * .2)) * uv.x;

	gl_FragColor = vec4(vec3(alpha), 1.);
}
