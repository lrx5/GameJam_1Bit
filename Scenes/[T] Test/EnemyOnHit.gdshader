shader_type canvas_item;
uniform vec4 damaged_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform float value = 0;
void fragment() {
	vec4 color = texture(TEXTURE, UV);
	color = mix(color, damaged_color, value * color.a);
	
	COLOR = color;
}


