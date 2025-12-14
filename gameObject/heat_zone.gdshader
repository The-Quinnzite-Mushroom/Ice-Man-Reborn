shader_type canvas_item;

uniform float pixel_size : hint_range(1.0, 64.0) = 8.0;
uniform float strength : hint_range(0.0, 0.05) = 0.02;
uniform float speed : hint_range(0.0, 5.0) = 1.5;
uniform float scale : hint_range(1.0, 20.0) = 8.0;
uniform sampler2D heat_texture;

void fragment() {
    float t = TIME * speed;

    // Wavy offset using sine noise
    float offset_x = sin((UV.y * scale) + t) * strength;
    float offset_y = cos((UV.x * scale) + t * 0.8) * strength;

    vec2 distorted_uv = UV + vec2(offset_x, offset_y);
	
	distorted_uv = floor(distorted_uv * pixel_size) / pixel_size;
	float noise = texture(heat_texture, distorted_uv).r;
	vec4 final_tex = vec4(1.0, 0 , 0, noise - 0.6);
	
	
	
	COLOR = final_tex;
	
}