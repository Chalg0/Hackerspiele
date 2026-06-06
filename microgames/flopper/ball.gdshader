shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

float atan2(vec2 v) {
    return mix(PI*.5 - atan(v.x,v.y), atan(v.y,v.x), float(abs(v.x) > abs(v.y)));
}

void fragment() {
	vec2 dc = UV - vec2(.5);
	float r2 = dot(dc, dc);
	if (r2 > .25) discard;
	float angle = atan2(dc);

	COLOR = vec4(.22, .45, .67, 1.);
	if (r2 > .2 || (angle < 0. && angle > -1. && r2 > .08 && r2 < .13)) COLOR.rgb *= .6;
}