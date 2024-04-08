shader_type canvas_item;

uniform float speed;

void fragment() {
	vec2 uv = vec2(UV.x, UV.y);
	uv.x = mod(uv.x + TIME*speed, 1.0);
	COLOR = texture(TEXTURE, uv);
}
