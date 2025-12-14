shader_type canvas_item;

uniform float border : hint_range(0.0, 0.5) = 0.1; 

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	
	
	float edge_factor = 1.0;
	vec4 final_tex = vec4(1, 0, 0, 0.25);
    // Left edge
    edge_factor *= smoothstep(0.0, border, UV.x);
    // Right edge
    edge_factor *= smoothstep(1.0, 1.0 - border, UV.x);
    // Top edge
    edge_factor *= smoothstep(0.0, border, UV.y);
    // Bottom edge
    edge_factor *= smoothstep(1.0, 1.0 - border, UV.y);

    final_tex.a *= edge_factor; // Apply fuzzy border to alpha
	
	COLOR = final_tex;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
