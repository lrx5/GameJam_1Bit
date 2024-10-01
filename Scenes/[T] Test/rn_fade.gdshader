shader_type canvas_item;

uniform float speed = 0;  // Speed of the movement
uniform float time;
uniform vec2 uv_offset = vec2(0, 0);

void fragment() {

    vec2 new_uv = UV + vec2(TIME * speed, 0.0);
    new_uv.x = mod(new_uv.x, 1.0);
	
    COLOR = texture(TEXTURE, new_uv);
}

