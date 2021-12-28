export class ParticleSystem {
  constructor() {
    this.particles = []
  }

  update = () => {
    this.particles.forEach(p => {
      p.resetForce()
    })

    this.particles = this.particles.filter(p => {
      p.update()
      return p.isArrive()
    })
  }

  draw = () => {
    this.particles.forEach(p => {
      p.draw()
    })
  }

  addParticle = p => {
    this.particles.push(p)
  }
}
