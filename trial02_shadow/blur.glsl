uniform sampler2D sampleTexture;
uniform vec3 textureSize;
uniform float amount; // 0 -
uniform bool isVertical;

void main(void)	{
  vec4 colorSum = vec4(0.0);
  float volumeSum = 0.0;
  for (int i = -int(amount); i <= int(amount); i++) {
    vec2 shiftCoord = vec2(float(i), 0.0);
    if (isVertical) {
      shiftCoord = vec2(0.0, float(i));
    }
    vec4 color = texture2D(
      sampleTexture,
      vec2(
        (gl_FragCoord.x + shiftCoord.x) / textureSize.x,
        ((textureSize.y - 1) - gl_FragCoord.y + shiftCoord.y) / textureSize.y
      )
    );
    float volume = amount + 1.0 - abs(float(i));
    colorSum += volume * color;
    volumeSum += volume;
  }
  gl_FragColor = vec4((colorSum / volumeSum).rgb, 1.0);
}
