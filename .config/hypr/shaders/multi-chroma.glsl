uniform float similarity;
uniform float similarity2;

uniform float amount;
uniform float amount2;

uniform float targetOpacity;
uniform float targetOpacity2;

uniform vec3 bg;
uniform vec3 bg2;

bool colorsSimilar(vec3 a, vec3 b, float s) {
    return a.r >= b.r - s && a.r <= b.r + s &&
        a.g >= b.g - s && a.g <= b.g + s &&
        a.b >= b.b - s && a.b <= b.b + s;
}

void windowShader(inout vec4 color) {
    if (colorsSimilar(color.rgb, bg, similarity)) {
        vec3 error = abs(color.rgb - bg);
        float avg_error = (error.r + error.g + error.b) / 3.0;

        color *= targetOpacity + (1.0 - targetOpacity) * avg_error * amount / similarity;
    }

    if (colorsSimilar(color.rgb, bg2, similarity2)) {
        vec3 error = abs(color.rgb - bg2);
        float avg_error = (error.r + error.g + error.b) / 3.0;

        color *= targetOpacity2 + (1.0 - targetOpacity) * avg_error * amount2 / similarity2;
    }
}
