shader_type canvas_item;

const int VRES = 120; // vertical resolution
const int HRES = VRES; // horizontal resolution
const vec3 COLOR_OFFSETS = vec3(-0.3, 0.0, 0.3) / float(HRES); // per color component offset
const vec2 SCREEN_BEND = vec2(.04, .05);
const vec2 SCREEN_FADE = vec2(100.);

void fragment() {
	vec2 margin = ((UV - .5) * (UV - .5)).yx;
	vec2 uv = UV - margin * SCREEN_BEND * (1. - UV * 2.);
	float alpha = 1. - dot(abs(clamp(uv, 0., 1.) - uv), SCREEN_FADE);

	float scanline_exp = sin(uv.x * 40. - TIME * 8.) * 0.06 + 0.2;

	float scanline_fract = fract(uv.y * float(VRES));
	float scanline_fac = pow(sin(PI * scanline_fract), scanline_exp);

	float ray_color = cos(fract(scanline_fract - TIME * 0.8) * PI);

	vec3 color = (alpha >= 1. ? vec3(
		texture(TEXTURE, uv + vec2(COLOR_OFFSETS.r, 0.)).r,
		texture(TEXTURE, uv + vec2(COLOR_OFFSETS.g, 0.)).g,
		texture(TEXTURE, uv + vec2(COLOR_OFFSETS.b, 0.)).b
	) * 0.9 : vec3(0.)) + vec3(ray_color * ray_color * .1);
	COLOR = vec4(color * scanline_fac * alpha, 1.0);
}