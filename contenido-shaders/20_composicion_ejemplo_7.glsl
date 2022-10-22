precision mediump float;

uniform vec2 u_resolution;
uniform float u_time;

#define PI 3.141592653589793


#define cx_mul(a, b) vec2(a.x*b.x - a.y*b.y, a.x*b.y + a.y*b.x)
#define cx_div(a, b) vec2(((a.x*b.x + a.y*b.y)/(b.x*b.x + b.y*b.y)),((a.y*b.x - a.x*b.y)/(b.x*b.x + b.y*b.y)))
#define cx_sin(a) vec2(sin(a.x) * cosh(a.y), cos(a.x) * sinh(a.y))
#define cx_cos(a) vec2(cos(a.x) * cosh(a.y), -sin(a.x) * sinh(a.y))

vec2 as_polar(vec2 z) {
  return vec2(
    length(z),
    atan(z.y, z.x)
  );
}

vec2 cx_log(vec2 a) {
    vec2 polar = as_polar(a);
    float rpart = polar.x;
    float ipart = polar.y;
    if (ipart > PI) ipart=ipart-(2.0*PI);
    return vec2(log(rpart),ipart);
}

vec3 palette( in float t, in vec3 a, in vec3 b, in vec3 c, in vec3 d ) {
    return a + b*cos( 0.38*2.*PI*(c*t+d) );
}

vec2 cx_pow(vec2 v, float p) {
  vec2 z = as_polar(v);
  return pow(z.x, p) * vec2(cos(z.y * p), sin(z.y * p));
}

float im(vec2 z) {
  return ((atan(z.y, z.x) / PI) + 1.0) * 0.5;
}

void main() {
  vec2 uv = (gl_FragCoord.xy - 0.5 * u_resolution.xy) / min(u_resolution.y, u_resolution.x);
  vec2 z = uv;
  
  float angle = sin(5.) * 2. * PI;
  float length = .1;
  
  // Spin our points in a circle of radius length
  float c = cos(angle);
  float s = sin(angle);
  vec2 p = vec2( s*length, c*length);
  vec2 q = vec2( s*-length, c*-length );
  
  // Divide z-p by z-q using complex division
  vec2 division = cx_pow(cx_div(((z) - p), (cx_pow(z, 2.) - q)),1.);
  
  // Calculate the log of our division
  vec2 log_p_over_q = cx_log(division);

  // Extract the imaginary number
  float imaginary = log_p_over_q.y / PI;

  vec3 col = palette( imaginary, vec3(0.502, 0.5137, 0.5294), vec3(.46,.32,.35), vec3(.82,.84,.65), vec3(0.53,0.23,0.22));

  gl_FragColor = vec4(col, 1.0);
}