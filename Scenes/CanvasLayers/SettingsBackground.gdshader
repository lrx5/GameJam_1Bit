shader_type canvas_item;

uniform float time;
uniform float amplitude = 5.0;
uniform float frequency = 10.0;

void fragment() {
    // Get the pixel size in UV coordinates (Godot 4 uses 'TEXTURE_PIXEL_SIZE')
    vec2 texture_size = vec2(textureSize(TEXTURE, 0));
    vec2 pixel_size = 1.0 / texture_size;

    // Round the x-coordinate to the nearest pixel column for pixel-perfect alignment
    float pixel_x = floor(SCREEN_UV.x / pixel_size.x) * pixel_size.x;

    // Create the wave offset using sine function
    float wave_offset = sin(pixel_x * frequency + time) * amplitude;

    // Adjust the y-coordinate by the wave offset, ensuring pixel-perfect movement
    vec2 uv = SCREEN_UV;
    uv.y += wave_offset * pixel_size.y;

    // Sample the texture using the modified UVs
    COLOR = texture(TEXTURE, uv);
}
