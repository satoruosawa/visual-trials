precision highp float;

uniform vec2 resolution;
uniform sampler2D buffer;
varying vec2 vTexCoord;

void main() {
  vec2 coord = vTexCoord + vec2(-1.0 / resolution.x, 0.0 / resolution.y);
  vec4 color = texture2D(buffer, coord);
  gl_FragColor = color;
}