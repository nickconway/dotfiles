#define MAX_COLORS 16

uniform float count;

uniform float similarity[MAX_COLORS];
uniform float amount[MAX_COLORS];
uniform float targetOpacity[MAX_COLORS];
uniform vec3 bg[MAX_COLORS];

bool colorsSimilar(vec3 a, vec3 b, float s) {
    return a.r >= b.r - s && a.r <= b.r + s &&
        a.g >= b.g - s && a.g <= b.g + s &&
        a.b >= b.b - s && a.b <= b.b + s;
}

void windowShader(inout vec4 color) {
    int loopCount = int(count);
    if (loopCount > MAX_COLORS) loopCount = MAX_COLORS;

    for (int i = 0; i < loopCount; i++) {
        vec3 bg = bg[i];
        float similarity = similarity[i];
        float amount = amount[i];
        float targetOpacity = targetOpacity[i];

        if (colorsSimilar(color.rgb, bg, similarity)) {
            vec3 error = abs(color.rgb - bg);
            float avg_error = (error.r + error.g + error.b) / 3.0;

            color *= targetOpacity + (1.0 - targetOpacity) * avg_error * amount / similarity;
        }
    }
}
