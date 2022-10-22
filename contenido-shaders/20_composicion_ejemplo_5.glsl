#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
#define PI 3.1415926535

float rand(vec2 co){return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);}
float rand (vec2 co, float l) {return rand(vec2(rand(co), l));}
float rand (vec2 co, float l, float t) {return rand(vec2(rand(co, l), t));}

float perlin(vec2 p, float dim, float time) {
	vec2 pos = floor(p * dim);
	vec2 posx = pos + vec2(1.0, 0.0);
	vec2 posy = pos + vec2(0.0, 1.0);
	vec2 posxy = pos + vec2(1.0);
	
	float c = rand(pos, dim, time);
	float cx = rand(posx, dim, time);
	float cy = rand(posy, dim, time);
	float cxy = rand(posxy, dim, time);
	
	vec2 d = fract(p * dim);
	d = -0.5 * cos(d * PI) + 0.5;
	
	float ccx = mix(c, cx, d.x);
	float cycxy = mix(cy, cxy, d.x);
	float center = mix(ccx, cycxy, d.y);
	
	return center * 2.0 - 1.0;
}

// p must be normalized!
float perlin(vec2 p, float dim) {
	
	/*vec2 pos = floor(p * dim);
	vec2 posx = pos + vec2(1.0, 0.0);
	vec2 posy = pos + vec2(0.0, 1.0);
	vec2 posxy = pos + vec2(1.0);
	
	// For exclusively black/white noise
	/*float c = step(rand(pos, dim), 0.5);
	float cx = step(rand(posx, dim), 0.5);
	float cy = step(rand(posy, dim), 0.5);
	float cxy = step(rand(posxy, dim), 0.5);*/
	
	/*float c = rand(pos, dim);
	float cx = rand(posx, dim);
	float cy = rand(posy, dim);
	float cxy = rand(posxy, dim);
	
	vec2 d = fract(p * dim);
	d = -0.5 * cos(d * PI) + 0.5;
	
	float ccx = mix(c, cx, d.x);
	float cycxy = mix(cy, cxy, d.x);
	float center = mix(ccx, cycxy, d.y);
	
	return center * 2.0 - 1.0;*/
	float c =  - (1. + sin(u_time));
	return perlin(p, dim + 0.000001, c * 0.0000008005);
}
float circuloLoopeado(vec2 uv) {
      return fract(
        (perlin(uv, 10.) + u_time) * fract(
          -distance(uv, vec2(0.5)) * 25./ (0. + u_time)
        ));
}

void main() {
	float time = u_time + 100.;
	vec2 uv = gl_FragCoord.xy/u_resolution.xy;

	float n = fract(0.01 * perlin(uv, 10. + .000005 * atan(1.* uv.x * uv.y)));

	float c = circuloLoopeado(uv);
	float x = 
		smoothstep(
			(distance(uv, vec2(c))),
			(.6),
			(1. + sin(PI * u_time))/ 2.);
	float r = distance(
		(n),
		distance(x / n, x * c) / pow(n, 1.)
	);

  gl_FragColor = vec4(
    vec3(
		0.2 + sin(5. * u_time) * 0.1 * r,
		.4 * x * c / n,
		n * x * (c * sin(u_time)))

  , 1.);
}

