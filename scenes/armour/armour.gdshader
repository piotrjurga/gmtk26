shader_type canvas_item;

uniform vec3 points[100];

void fragment() {
    if (COLOR.a != 0.0) {
        float min_dist = 1000.0;
        float dist = 0.0;
        float click_size = 0.0;
        for(int i = 0; i < 100; i++) { 
            if (points[i] == vec3(0.0)){
                i = 100;
            } else {
                dist = distance(FRAGCOORD.xy, points[i].xy);
                if (dist < min_dist && dist < points[i].z) {
                    min_dist = dist;
                    click_size = points[i].z;
                }
            }
        }
        float new_color = 1.0;
        if (min_dist < click_size) {
            new_color = 0.0;
        }
        if (new_color < COLOR.a) {
            COLOR.a = new_color;
        }
    }
}
