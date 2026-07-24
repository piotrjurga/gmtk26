shader_type canvas_item;

uniform float top_cutoff = 0.0;
uniform float bot_cutoff = 0.0;
uniform float left_cutoff = 0.0;
uniform float right_cutoff = 0.0;

void fragment() {
	if (top_cutoff != 0.0 && FRAGCOORD.y < top_cutoff) {
        COLOR.a = 0.0;
    }
	if (bot_cutoff != 0.0 && FRAGCOORD.y > bot_cutoff) {
        COLOR.a = 0.0;
    }
	if (left_cutoff != 0.0 && FRAGCOORD.x < left_cutoff) {
        COLOR.a = 0.0;
    }
	if (right_cutoff != 0.0 && FRAGCOORD.x > right_cutoff) {
        COLOR.a = 0.0;
    }
}
