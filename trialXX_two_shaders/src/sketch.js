import frag from './shaders/test.frag'
import vert from './shaders/test.vert'

let bufferArray = []
let shaderArray = []

export const Sketch = p5 => {
  let backBufferIsZero = true

  const backBuffer = () => bufferArray[backBufferIsZero ? 0 : 1]

  const frontBuffer = () => bufferArray[backBufferIsZero ? 1 : 0]

  const backShader = () => shaderArray[backBufferIsZero ? 0 : 1]

  const frontShader = () => shaderArray[backBufferIsZero ? 1 : 0]

  p5.preload = () => {
    for (let i = 0; i < 2; i++) {
      shaderArray[i] = p5.loadShader(vert, frag)
    }
  }

  p5.setup = () => {
    p5.createCanvas(100, 100, p5.WEBGL)
    for (let i = 0; i < 2; i++) {
      bufferArray[i] = p5.createGraphics(p5.width, p5.height, p5.WEBGL)
      bufferArray[i].fill(0)
      bufferArray[i].noStroke()
    }
    backBuffer().rect(-49, -49, 1, 1)
  }

  p5.draw = () => {
    frontBuffer().shader(frontShader())
    frontShader().setUniform('resolution', [p5.width, p5.height])
    frontShader().setUniform('buffer', backBuffer())
    frontBuffer().rect(-p5.width / 2, -p5.height / 2, p5.width, p5.height)
    p5.background(255)
    p5.image(frontBuffer(), -p5.width / 2, -p5.height / 2, p5.width, p5.height)
    backBufferIsZero = !backBufferIsZero
  }
}
