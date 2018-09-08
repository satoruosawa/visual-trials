uniform sampler2D sampleTexture;
uniform vec3 textureSize;
uniform vec3 amount;

void main(void)	{
  vec2 refCoord = vec2(
    gl_FragCoord.x / textureSize.x,
    1.0 - gl_FragCoord.y / textureSize.y
  );
  refCoord -= amount.xy / textureSize.xy;
  vec4 tColor = texture2D(sampleTexture, refCoord);
  gl_FragColor = tColor;
}
