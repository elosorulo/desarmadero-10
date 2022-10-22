// Author:
// Title:

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;


vec2 random2(vec2 st){
    st = vec2( dot(st,vec2(127.1,311.7)),
              dot(st,vec2(269.5,183.3)) );
    return -1.0 + 2.0*fract(sin(st)*43758.5453123);
}

// Gradient Noise by Inigo Quilez - iq/2013
// https://www.shadertoy.com/view/XdXGW8
float noise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    vec2 u = f*f*(3.0-2.0*f);

    return mix( mix( dot( random2(i + vec2(0.0,0.0) ), f - vec2(0.0,0.0) ),
                     dot( random2(i + vec2(1.0,0.0) ), f - vec2(1.0,0.0) ), u.x),
                mix( dot( random2(i + vec2(0.0,1.0) ), f - vec2(0.0,1.0) ),
                     dot( random2(i + vec2(1.0,1.0) ), f - vec2(1.0,1.0) ), u.x), u.y);
}

float circle(float radius, vec2 uv) {
	return 1. + -1. * smoothstep(radius, radius + 0.42, length(uv));
}

float between(float edge_1, float x) {
    return 1. + -1. * smoothstep(edge_1, 0.0000016, length(x));
}

float square(float x_edge_1, float y_edge_1, vec2 uv) {
	return between(x_edge_1, uv.x) * between(y_edge_1, uv.y);
}

void main() {
    vec2 uv = gl_FragCoord.xy/u_resolution.xy;
	
    uv = fract(uv * 6.);
    
	float n = noise(vec2(9. * u_time)/ uv * uv);
    
    float r = circle(0.22 + 0.355 * cos(2.5 * (u_time)), uv - vec2(0.5)) * square(n * 0.125, 0.315, uv - vec2(0.5));
    
    r = 0.4 + fract(r * log(100. * u_time));
    
    gl_FragColor = vec4(vec3(.72 + sin(3. * u_time)*log(0.1 * r * u_time), r * 0.6, r * 0.7), 1.);
}
