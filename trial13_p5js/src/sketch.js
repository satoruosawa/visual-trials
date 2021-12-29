import { Field } from './field.js'
import { Particle } from './particle.js'
import { ParticleSystem } from './particle-system.js'
import { Ticker } from './ticker.js'

export const Sketch = p5 => {
  let field
  let canvas
  const particleSystem = new ParticleSystem()
  const rectSize = 25
  let pGraphics
  const ticker = new Ticker()
  let notoSans
  let isInteracted = false

  p5.preload = () => {
    notoSans = p5.loadFont('assets/NotoSans-Regular.ttf')
  }

  p5.setup = () => {
    canvas = p5.createCanvas(1000, 1000)
    pGraphics = p5.createGraphics(p5.width, p5.height)
    field = new Field(p5, rectSize, p5.width / rectSize, p5.height / rectSize)
    pGraphics.textFont(notoSans)
    pGraphics.textSize(600)
    pGraphics.noStroke()
    pGraphics.fill(0)
    pGraphics.textAlign(p5.CENTER, p5.CENTER)
    p5.textFont(notoSans)
    p5.textSize(100)
    p5.textAlign(p5.CENTER, p5.CENTER)
  }

  const update = () => {
    ticker.update()
    if (ticker.frameCount % 180 == 0) {
      const number = (ticker.frameCount / 180) % 10
      pGraphics.background(255)
      pGraphics.text(number, p5.width / 2, p5.height / 2 - 100)
      pGraphics.loadPixels()
      const pixelDensity = p5.pixelDensity()
      for (let j = 0; j < pGraphics.height; j += 2) {
        for (let i = 0; i < pGraphics.width; i += 2) {
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
            p.baseColor = c
          }
        }
      }
    }
    field.update()
    particleSystem.update()
  }

  p5.draw = () => {
    update()
    p5.background(255)
    particleSystem.draw()
    if (!isInteracted) {
      p5.fill(255, 200)
      p5.noStroke()
      p5.rectMode(p5.CENTER)
      p5.rect(p5.width / 2, p5.height / 2, 500, 200, 20)
      p5.fill(255, 0, 0)
      p5.text('Mix here!!', p5.width / 2, p5.height / 2 - 15)
      p5.rectMode(p5.CORNER)
    }
  }

  p5.mouseMoved = () => {
    isInteracted = true
    const diffMouse = p5
      .createVector(p5.mouseX - p5.pmouseX, p5.mouseY - p5.pmouseY)
      .mult(2)
    const position = p5.createVector(p5.mouseX, p5.mouseY)
    field && field.addLerpVelocity(position, diffMouse)
  }

  p5.touchMoved = () => {
    isInteracted = true
    const diffMouse = p5
      .createVector(p5.mouseX - p5.pmouseX, p5.mouseY - p5.pmouseY)
      .mult(2)
    const position = p5.createVector(p5.touches[0].x, p5.touches[0].y)
    field && field.addLerpVelocity(position, diffMouse)
  }

  p5.keyPressed = () => {
    if (p5.key === 's') {
      p5.saveCanvas(canvas, 'screenshot.png')
    }
  }
}
