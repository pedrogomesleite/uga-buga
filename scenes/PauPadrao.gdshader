shader_type canvas_item;

uniform vec4 shadow_color : source_color = vec4(0.0, 0.0, 0.0, 0.5);
uniform vec2 offset = vec2(5.0, 5.0);
uniform float blur_amount : hint_range(0.0, 5.0) = 2.0;

void fragment() {
    vec4 sprite_color = texture(TEXTURE, UV);
    vec2 ps = TEXTURE_PIXEL_SIZE;
    
    float shadow_alpha = 0.0;
    
    for(float x = -1.0; x <= 1.0; x++) {
        for(float y = -1.0; y <= 1.0; y++) {
            vec2 blur_offset = vec2(x, y) * blur_amount;
            shadow_alpha += texture(TEXTURE, UV - (offset + blur_offset) * ps).a;
        }
    }
    
    shadow_alpha /= 9.0;
    
    vec3 final_color = mix(shadow_color.rgb, sprite_color.rgb, sprite_color.a);
    
    float final_alpha = max(sprite_color.a, shadow_alpha * shadow_color.a);
    
    COLOR = vec4(final_color, final_alpha);
}