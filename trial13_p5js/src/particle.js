export class Particle {
  constructor(p5) {
    this.p5 = p5
    this.fields = []
    this.position = this.p5.createVector(0, 0)
    this.velocity = this.p5.createVector(0, 0)
    this.force = this.p5.createVector(0, 0)
    this.life = 180
    this.size = 1
  }

  update = () => {
    this.fields.forEach(f => f.willUpdateParticle(this))
    this.updatePosition()
    this.fields.forEach(f => f.didUpdateParticle(this))
    this.life -= 1
  }

  updatePosition = () => {
    this.velocity.add(this.force)
    this.position.add(this.velocity)
  }

  draw = () => {
    this.p5.noStroke()
    this.p5.fill(255 * (1 - this.life / 180))
    this.p5.rect(this.position.x, this.position.y, this.size, this.size)
  }

  addField = f => {
    this.fields.push(f)
  }

  resetForce = () => {
    this.force.set(0, 0)
  }

  addForce = f => {
    this.force.add(f)
  }

  isArrive = () => {
    if (this.life > 0) {
      return true
    }
    return false
  }

  // position = p => {
  //   this.position = p
  // }

  // velocity = p => {
  //   this.velocity = p
  // }
}
