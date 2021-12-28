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

let bufferArray = []
let shaderArray = []

export const Sketch = p5 => {
  let isFirstPGraphics = true

  const backBuffer = () => {
    return bufferArray[isFirstPGraphics ? 0 : 1]
  }

  const frontBuffer = () => {
    return bufferArray[isFirstPGraphics ? 1 : 0]
  }

  const backShader = () => {
    return shaderArray[isFirstPGraphics ? 0 : 1]
  }

  const frontShader = () => {
    return shaderArray[isFirstPGraphics ? 1 : 0]
  }

  p5.setup = () => {
    p5.createCanvas(100, 100, p5.WEBGL)
    for (let i = 0; i < 2; i++) {
      bufferArray[i] = p5.createGraphics(p5.width, p5.height, p5.WEBGL)
      shaderArray[i] = bufferArray[i].createShader(vs, fs)
      bufferArray[i].fill(0)
      bufferArray[i].noStroke()
    }
    backBuffer().rect(-49, -49, 1, 1)
  }

  p5.draw = () => {
    frontBuffer().shader(frontShader())
    frontShader().setUniform('resolution', [p5.width, p5.height])
    frontShader().setUniform('buffer', backBuffer())
    frontBuffer().rect(-50, -50, 100, 100)
    p5.image(frontBuffer(), -50, -50, p5.width, p5.height)
    isFirstPGraphics = !isFirstPGraphics
  }
}
