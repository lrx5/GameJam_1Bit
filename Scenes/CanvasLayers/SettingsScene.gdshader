shader_type canvas_item;

uniform float time;
uniform float amplitude = 5.0;  // Height of the wave
uniform float frequency = 10.0; // Frequency of the wave

void fragment() {
    // Get the pixel size in UV coordinates to make the effect pixel-perfect
    vec2 pixel_size = 1.0 / TEXTURE_PIXEL_SIZE;

    // Round the x-coordinate to the nearest pixel column
    float pixel_x = floor(FRAGCOORD.x / pixel_size.x) * pixel_size.x;

    // Calculate the wave offset based on time, frequency, and amplitude
    float wave_offset = sin(pixel_x * frequency + time) * amplitude;

    // Shift the y-coordinate by the wave offset
    vec2 uv = FRAGCOORD.xy / SCREEN_PIXEL_SIZE;
    uv.y += wave_offset * pixel_size.y;

    // Sample the texture using the modified UVs
    COLOR = texture(TEXTURE, uv);
}