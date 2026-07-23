shader_type canvas_item;

uniform float rope_top_cutoff = 270.0;

void fragment() {
	if (FRAGCOORD.y < rope_top_cutoff) {
        COLOR.a = 0.0;
    }
}
