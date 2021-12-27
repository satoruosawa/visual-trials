import { ParticleSystem } from './particle-system.js'
import { Particle } from './particle.js'

let tracks = 0

export const Sketch = p5 => {
  const particleSystem = new ParticleSystem(p5)

  p5.setup = () => {
    p5.createCanvas(1000, 1000)
    p5.background('#f5f5f5')
  }

  const drawLine = () => {
    const p = new Particle(p5)
    p.position = p5.createVector(
      p5.random(0, p5.width),
      p5.random(0, p5.height)
    )
    p.velocity = p5.createVector(p5.random(-0.2, 0.2), p5.random(-0.2, 0.2))
    particleSystem.addParticle(p)
  }

  const update = () => {
    if (p5.mouseIsPressed) {
      drawLine()
    } else {
      tracks += p5.dist(0, 0, p5.movedX, p5.movedY)
      if (tracks > 20) {
        drawLine()
        tracks = 0
      }
    }
    particleSystem.update()
  }

  p5.draw = () => {
    update()
    p5.fill(255, 10)
    p5.rect(0, 0, p5.width, p5.height)
    p5.noFill()
    p5.strokeWeight(4)
    p5.stroke(0)
    p5.beginShape()
    particleSystem.draw()
    p5.endShape()
  }
}
