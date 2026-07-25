shader_type canvas_item;

uniform float top_cutoff = 0.0;
uniform float bot_cutoff = 0.0;
uniform float left_cutoff = 0.0;
uniform float right_cutoff = 0.0;

void fragment() {
    float y = FRAGCOORD.y * SCREEN_PIXEL_SIZE.y;
    float x = FRAGCOORD.x * SCREEN_PIXEL_SIZE.x;
	if (top_cutoff != 0.0 && y < (top_cutoff / 1080.0)) {
        COLOR.a = 0.0;
    }
	if (bot_cutoff != 0.0 && y > (bot_cutoff / 1080.0)) {
        COLOR.a = 0.0;
    }
	if (left_cutoff != 0.0 && x < (left_cutoff / 1920.0)) {
        COLOR.a = 0.0;
    }
	if (right_cutoff != 0.0 && x > (right_cutoff / 1920.0)) {
        COLOR.a = 0.0;
    }
}
