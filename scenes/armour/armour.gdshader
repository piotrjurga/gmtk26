shader_type canvas_item;

uniform vec2 points[100];
uniform float click_size;

void fragment() {
    if (COLOR.a != 0.0) {
        float min_dist = click_size;
        float dist = 0.0;
        for(int i = 0; i < 100; i++) { 
            if (points[i] == vec2(0.0)){
                i = 100;
            } else {
                dist = distance(FRAGCOORD.xy, points[i]);
                if (dist < min_dist) {
                    min_dist = dist;
                }
            }
        }
        float new_color = 1.0;
        if (min_dist < click_size - (click_size / 10.0)) {
            new_color = 0.0;
        } else if (min_dist < click_size) {
            new_color = min_dist / 100.0;
        }
        if (new_color < COLOR.a) {
            COLOR.a = new_color;
        }
    }
}
