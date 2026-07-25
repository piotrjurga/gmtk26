shader_type canvas_item;

uniform vec3 points[100];
uniform vec2 screen_size = vec2(1920.0, 1080.0);

void fragment() {
    float x = FRAGCOORD.x * SCREEN_PIXEL_SIZE.x * screen_size.x;
    float y = FRAGCOORD.y * SCREEN_PIXEL_SIZE.y * screen_size.y;

    if (COLOR.a != 0.0) {
        float min_dist = 1000.0;
        float dist = 0.0;
        float click_size = 0.0;
        for(int i = 0; i < 100; i++) { 
            if (points[i] == vec3(0.0)) {
                i = 100;
            } else {
                vec2 screen_pos = vec2(points[i].x / screen_size.x, points[i].y / screen_size.y);
                dist = distance(vec2(x, y), points[i].xy);
                //float point_size = points[i].z * 0.0005;
                float point_size = points[i].z;
                if (dist < min_dist && dist < point_size) {
                    min_dist = dist;
                    click_size = point_size;
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
