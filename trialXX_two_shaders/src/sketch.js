import frag from './shaders/test.frag'
import vert from './shaders/test.vert'

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
    frontBuffer().rect(-50, -50, 100, 100)
    p5.image(frontBuffer(), -50, -50, p5.width, p5.height)
    isFirstPGraphics = !isFirstPGraphics
  }
}
