export class Particle {
  constructor(p5) {
    this.p5 = p5
    this.position = new this.p5.createVector(0, 0)
    this.velocity = new this.p5.createVector(0, 0)
    this.force = new this.p5.createVector(0, 0)
    this.life = 20
  }

  update() {
    this.updatePosition()
    this.life -= 1
  }

  updatePosition() {
    this.velocity.add(this.force)
    this.position.add(this.velocity)
  }

  draw() {
    this.p5.curveVertex(this.position.x, this.position.y)
  }

  resetForce() {
    this.force.set(0, 0)
  }

  isArrive() {
    if (this.life > 0) {
      return true
    }
    return false
  }

  position = p => {
    this.position = p
  }

  velocity = p => {
    this.velocity = p
  }
}
