import { Field } from './field.js'
import { Particle } from './particle.js'
import { ParticleSystem } from './particle-system.js'
import { Ticker } from './ticker.js'

export const Sketch = p5 => {
  let field
  let canvas
  const particleSystem = new ParticleSystem()
  const rectSize = 10
  let pGraphics
  const ticker = new Ticker()

  p5.setup = () => {
    canvas = p5.createCanvas(1000, 1000)
    pGraphics = p5.createGraphics(p5.width, p5.height)
    field = new Field(p5, rectSize, p5.width / rectSize, p5.height / rectSize)
  }

  const update = () => {
    ticker.update()
    if (ticker.frameCount % 180 == 0) {
      // pGraphics.beginDraw()

      // pGraphics.textFont(GARAMOND_450);
      pGraphics.textSize(450)
      pGraphics.background(255)
      pGraphics.noStroke()
      pGraphics.fill(0)
      pGraphics.textAlign(p5.CENTER, p5.CENTER)
      pGraphics.text(
        // str(int(ticker.frameCount / 60)),
        '1',
        p5.width / 2,
        p5.height / 2
      )
      pGraphics.loadPixels()
      const pixelDensity = p5.pixelDensity()
      for (let j = 0; j < pGraphics.height; j++) {
        for (let i = 0; i < pGraphics.width; i++) {
          const index =
            (j * pixelDensity * pGraphics.width * pixelDensity +
              i * pixelDensity) *
            4
          const c = pGraphics.pixels[index]
          if (c != 255) {
            const p = new Particle(p5)
            p.position = p5.createVector(i, j)
            particleSystem.addParticle(p)
            p.addField(field)
          }
        }
      }

      // pGraphics.endDraw()
    }
    field.update()
    particleSystem.update()
  }

  p5.draw = () => {
    update()
    p5.background(255)
    particleSystem.draw()
  }

  p5.mouseMoved = () => {
    const diffMouse = p5
      .createVector(p5.mouseX - p5.pmouseX, p5.mouseY - p5.pmouseY)
      .mult(2)
    const position = p5.createVector(p5.mouseX, p5.mouseY)
    field && field.addLerpVelocity(position, diffMouse)
  }

  p5.keyPressed = () => {
    if (p5.key === 's') {
      p5.saveCanvas(canvas, 'screenshot.png')
    }
  }
}
