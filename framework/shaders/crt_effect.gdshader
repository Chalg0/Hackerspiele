shader_type canvas_item;

const int VRES = 120; // vertical resolution
const int HRES = VRES; // horizontal resolution

// per color component offset
const vec3 COLOR_OFFSETS = vec3(-0.3, 0.0, 0.3) / float(HRES);

void fragment() {
	float scanline_exp = sin(UV.x * 40. - TIME * 8.) * 0.06 + 0.2;

	float scanline_fract = fract(UV.y * float(VRES));
	float scanline_fac = pow(sin(PI * scanline_fract), scanline_exp);

	float ray_color = cos(fract(scanline_fract - TIME * 0.8) * PI);

	vec3 color = vec3(
		texture(TEXTURE, UV + vec2(COLOR_OFFSETS.r, 0.)).r,
		texture(TEXTURE, UV + vec2(COLOR_OFFSETS.g, 0.)).g,
		texture(TEXTURE, UV + vec2(COLOR_OFFSETS.b, 0.)).b
	) * 0.9 + vec3(ray_color * ray_color * .1);
	COLOR = vec4(color * scanline_fac, 1.0);
}