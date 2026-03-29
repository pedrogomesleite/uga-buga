shader_type canvas_item;
render_mode blend_premul_alpha;

uniform sampler2D noise_tex_normal;
uniform sampler2D noise_tex;
uniform float strength = 1.0;
uniform float pixel_count : hint_range(1.0, 512.0) = 64.0;
uniform float alpha_threshold : hint_range(0.0, 1.0) = 0.1;

uniform vec4 hole_color : source_color = vec4(1.0, 0.3, 0.0, 1.0); // Cor da borda
uniform float hole_thickness : hint_range(0.0, 0.2) = 0.05;      // Grossura da borda
uniform float hole_glow : hint_range(1.0, 10.0) = 2.0;           // Brilho da borda

uniform vec4 inside_color : source_color = vec4(0.0, 0.0, 0.0, 1.0); // Cor de fundo do buraco
uniform float inside_alpha : hint_range(0.0, 1.0) = 1.0;             // Opacidade do fundo

void fragment() { 
    float auto_progress = 0.25 + (sin(TIME) * 0.5 + 0.5) * (0.50 - 0.25);
    
    float pixel_size = 1.0 / pixel_count;
    vec2 pixel_uv = floor(UV / pixel_size) * pixel_size;

    vec2 direction = texture(noise_tex_normal, pixel_uv).xy;
    direction = (direction - 0.5) * 2.0;
    direction *= strength * auto_progress;
    vec2 distorted_uv = pixel_uv - direction;

    vec4 tex = texture(TEXTURE, distorted_uv);

    float base_alpha = texture(TEXTURE, UV).a; 

    float noise_val = texture(noise_tex, pixel_uv).x;
    
    float visible_mask = step(auto_progress + hole_thickness, noise_val);
    
    float edge_mask = step(auto_progress, noise_val) - step(auto_progress + hole_thickness, noise_val);
    
    float inside_mask = 1.0 - step(auto_progress, noise_val);

    vec3 color_mix;
    float alpha_mix;

    if (visible_mask > 0.0) {
        color_mix = tex.rgb;
        alpha_mix = tex.a;
    } else if (edge_mask > 0.0) {
        color_mix = hole_color.rgb * hole_glow;
        alpha_mix = hole_color.a;
    } else {
        color_mix = inside_color.rgb;
        alpha_mix = inside_alpha;
    }

    COLOR = vec4(color_mix, alpha_mix * base_alpha) * COLOR;
}