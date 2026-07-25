shader_type canvas_item;

uniform float rope_top_cutoff = 270.0;

void fragment() {
    float y = FRAGCOORD.y * SCREEN_PIXEL_SIZE.y;
	if (y < (rope_top_cutoff / 1080.0)) {
        COLOR.a = 0.0;
    }
}
