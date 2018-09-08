uniform sampler2D baseTexture;
uniform sampler2D overlayTexture;
uniform vec3 textureSize;
uniform int overlayMode = 0;

void main(void)	{
  vec4 baseColor = texture2D(
    baseTexture,
    vec2(
      gl_FragCoord.x / textureSize.x,
      ((textureSize.y - 1) - gl_FragCoord.y) / textureSize.y
    )
  );
  vec4 overlayColor = texture2D(
    overlayTexture,
    vec2(
      gl_FragCoord.x / textureSize.x,
      ((textureSize.y - 1) - gl_FragCoord.y) / textureSize.y
    )
  );
  vec4 color = baseColor;
  if (overlayMode == 0) {
    if (overlayColor.r == 0) {
      color = vec4(1.0);
    }
  }
  gl_FragColor = vec4(color.rgb, 1.0);
}
