shader_type spatial;

const vec3 BASE_COLOR = vec3(.55, .55, .15);
const float STICKY_PART_HEIGHT = .15;
const vec3 STICKY_COLOR = BASE_COLOR * .9;

uniform sampler2D foreground;

void vertex() {
	float t = TIME * 2.;
	VERTEX.x += pow(UV.x * UV.y, 5.) * (.04 + sin(t) * .04)
	          + (sin(t * 1.37) + 1.) * UV.y * .01;
}

void fragment() {
	vec3 bg = mix(STICKY_COLOR, BASE_COLOR, clamp(1. + min(UV.y - STICKY_PART_HEIGHT, 0.) * 40., 0.0, 1.0));
	vec4 fg = texture(foreground, UV);
	ALBEDO = mix(bg, fg.rgb, fg.a);
}