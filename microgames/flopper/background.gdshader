shader_type canvas_item;

const float size = 60.;
const vec3 C = vec3(.2, .2, .4);
const vec3 C1 = C * .1;
const vec3 C2 = C * .25;

void fragment() {
	vec2 uv = SCREEN_UV;
	float aspect = SCREEN_PIXEL_SIZE.x / SCREEN_PIXEL_SIZE.y;
	vec2 uv2 = uv * size * vec2(1., aspect);
	ivec2 uvi = ivec2(uv2);
	int uvd = (uvi.x + uvi.y) % 3;
	float t1 = mod(TIME, 3.);
	float t2 = fract(t1);
	int t3 = int(t1);
	COLOR.a = 1.;
	if (uvd == 0)      COLOR.rgb = mix(C1, C2, (t3 == 0) ? t2 : (t3 == 1)?(1.-t2):0.);
	else if (uvd == 1) COLOR.rgb = mix(C1, C2, (t3 == 1) ? t2 : (t3 == 2)?(1.-t2):0.);
	else               COLOR.rgb = mix(C1, C2, (t3 == 2) ? t2 : (t3 == 0)?(1.-t2):0.);
}