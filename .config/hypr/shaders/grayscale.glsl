uniform float scale;

void windowShader(inout vec4 color) {
    float shade = (color.r + color.g + color.b) / 3.0;

    vec3 gray = vec3(shade);
    vec3 c = vec3(color.r, color.g, color.b);

    vec3 difference = c - gray;

    vec3 result = c - (scale * difference);

    color.rgb = result;
}
