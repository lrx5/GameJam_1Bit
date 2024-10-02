shader_type canvas_item;

uniform float outline_thickness = 1.0;
uniform vec4 white = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 normal = vec4(0.0, 0.0, 0.0, 1.0); 
uniform bool hover_effect = false;

void fragment() {
vec2 pixel_uv = UV * vec2(36.0, 36.0);
	if (hover_effect){
		if (pixel_uv.y < outline_thickness)
		{COLOR = white;}
		else if (pixel_uv.y > 36.0 - outline_thickness)
		{COLOR = white;}
		else if (pixel_uv.x < outline_thickness)
		{COLOR = white;}
		else if (pixel_uv.x > 36.0 - outline_thickness)
		{COLOR = white;}
		else {COLOR = normal;}
	}
}
