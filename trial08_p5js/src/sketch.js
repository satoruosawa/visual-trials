import { ParticleSystem } from './particle-system.js'
import { Particle } from './particle.js'

export const Sketch = p5 => {
  const particleSystem = new ParticleSystem(p5)

  p5.setup = () => {
    p5.createCanvas(1000, 1000)
    p5.background(255)
  }

  const drawLine = () => {
    const p = new Particle(p5)
    p.position = p5.createVector(
      p5.random(0, p5.width),
      p5.random(0, p5.height)
    )
    p.velocity = p5.createVector(p5.random(-2, 2), p5.random(-2, 2))
    particleSystem.addParticle(p)
  }

  const update = () => {
    if (p5.mouseIsPressed) {
      for (let i = 0; i < 1; i++) {
        drawLine()
      }
    }
    particleSystem.update()
  }

  p5.draw = () => {
    update()
    p5.fill(255, 10)
    p5.rect(0, 0, p5.width, p5.height)
    p5.noFill()
    p5.strokeWeight(0.05)
    p5.stroke(0)
    p5.beginShape()
    particleSystem.draw()
    p5.endShape()
    // p5.loadPixels()
    // p5.pixels.set(p5.pixels.map(pixel => p5.constrain(pixel + 1, 0, 255)))
    // p5.updatePixels()
  }
}
