shader_type canvas_item;

uniform float time;
uniform float amplitude = 0.0;
uniform float frequency = 0.0;

void fragment() {
    // Get the pixel size in UV coordinates (Godot 4 uses 'TEXTURE_PIXEL_SIZE')
    vec2 texture_size = vec2(textureSize(TEXTURE, 0));
    vec2 pixel_size = 1.0 / texture_size;

    // Round the y-coordinate to the nearest pixel column for pixel-perfect alignment
    float pixel_y = floor(SCREEN_UV.y / pixel_size.y) * pixel_size.y;

    // Create the wave offset using sine function
    float wave_offset = sin(pixel_y * frequency + time) * amplitude;

    // Adjust the x-coordinate by the wave offset, ensuring pixel-perfect movement
    vec2 uv = SCREEN_UV;
    uv.x += wave_offset * pixel_size.x;

    // Sample the texture using the modified UVs
    COLOR = texture(TEXTURE, uv);
}
