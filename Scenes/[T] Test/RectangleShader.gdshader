shader_type canvas_item;

uniform vec4 gradient_color = vec4(0.6, 0.6, 1.0, 1.0);  // Base color (white)
uniform float gradient_strength = 1.0;  // Control the gradient strength
uniform float scroll_speed = 1.0;  // Speed of the scrolling effect
uniform float wave_amplitude = 10.0;  // Amplitude of the wave distortion
uniform float wave_frequency = 10.0;  // Frequency of the wave distortion

void fragment() {
    // Scroll the UVs downwards over time
    vec2 scrolling_uv = UV + vec2(0.0, TIME * scroll_speed);

    // Wrap the UVs to create a repeating effect
    scrolling_uv.y = mod(scrolling_uv.y, 1.0);

    // Add wave distortion to the UVs
    scrolling_uv.x += sin(scrolling_uv.y * wave_frequency) * wave_amplitude;

    // Calculate the distance from the center in the y-direction
    float distance_from_center = abs(scrolling_uv.y - 0.5) * 2.0;  // Scale to 0.0 at the center and 1.0 at the edges

    // Calculate alpha based on the distance, with a smooth transition
    float alpha = 1.0 - distance_from_center * gradient_strength;

    // Set the alpha to 0.0 if it exceeds the bounds
    alpha = clamp(alpha, 0.0, 1.0);

    // Set the final color with the calculated alpha
    COLOR = vec4(gradient_color.rgb, alpha);
}
