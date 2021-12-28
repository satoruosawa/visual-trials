const vs = `
precision highp float;

attribute vec3 aPosition;
attribute vec2 aTexCoord;
varying vec2 vTexCoord;

uniform mat4 uProjectionMatrix;
uniform mat4 uModelViewMatrix;

void main() {
  vTexCoord = aTexCoord;
  vec4 positionVec4 = vec4(aPosition, 1.0);
  gl_Position = uProjectionMatrix * uModelViewMatrix * positionVec4;
}
`

const fs = `
precision highp float;

uniform vec2 resolution;
uniform sampler2D buffer;
varying vec2 vTexCoord;

void main() {
  vec2 coord = vTexCoord + vec2(-1.0 / resolution.x, 0.0 / resolution.y);
  vec4 color = texture2D(buffer, coord);
  gl_FragColor = color;
}
`

let theShader0
let theShader1
let backbuffer0
let backbuffer1

export const Sketch = p5 => {
  let flag = true

  p5.setup = () => {
    p5.createCanvas(100, 100, p5.WEBGL)
    backbuffer0 = p5.createGraphics(p5.width, p5.height, p5.WEBGL)
    backbuffer1 = p5.createGraphics(p5.width, p5.height, p5.WEBGL)
    theShader0 = backbuffer0.createShader(vs, fs)
    theShader1 = backbuffer1.createShader(vs, fs)
    backbuffer0.fill(0)
    backbuffer0.noStroke()
    backbuffer1.fill(0)
    backbuffer1.noStroke()
    backbuffer0.rect(-49, -49, 1, 1)
  }

  p5.draw = () => {
    if (flag) {
      backbuffer1.shader(theShader1)
      theShader1.setUniform('resolution', [p5.width, p5.height])
      theShader1.setUniform('buffer', backbuffer0)
      backbuffer1.rect(-50, -50, 100, 100)
      p5.image(backbuffer1, -50, -50, p5.width, p5.height)
    } else {
      backbuffer0.shader(theShader0)
      theShader0.setUniform('resolution', [p5.width, p5.height])
      theShader0.setUniform('buffer', backbuffer1)
      backbuffer0.rect(-50, -50, 100, 100)
      p5.image(backbuffer0, -50, -50, p5.width, p5.height)
    }
    flag = !flag
  }
}
