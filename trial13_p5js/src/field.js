export class Field {
  // let gridSize;
  // let numColumn;
  // let numRow;
  // const prevVelocities=[]
  // const velocities=[]
  //  prevPressures=[]
  //  pressures=[]

  constructor(p5, gridSize, numColumn, numRow) {
    this.p5 = p5
    this.gridSize = gridSize
    this.numColumn = numColumn
    this.numRow = numRow
    this.prevVelocities = []
    this.velocities = []
    this.prevPressures = []
    this.pressures = []
    for (let i = 0; i < this.numColumn * this.numRow; i++) {
      this.prevVelocities[i] = this.p5.createVector(0, 0)
      this.velocities[i] = this.p5.createVector(0, 0)
      this.prevPressures[i] = 0.0
      this.pressures[i] = 0.0
    }
  }

  update = () => {
    // Navier Stokes equations
    this.updteConvection()
    this.updateDiffusion()
    this.updatePressure()
  }

  updteConvection = () => {
    // let v1 = this.p5.createVector(6, 4, 2)
    // let v2 = this.p5.p5.Vector.div(v1, 2)
    // console.log(v1)
    // console.log(v2)
    // console.log(this.p5)
    // console.log(this.p5.constructor.Vector)
    for (let i = 0; i < this.numColumn; i++) {
      for (let j = 0; j < this.numRow; j++) {
        // semi-Lagrangian
        const velocityPosition = this.p5.createVector(i, j).mult(this.gridSize)
        const prevVelocityPosition = velocityPosition.sub(
          this.prevVelocities[this.getIndex(i, j)]
        )
        const prevVelocityRef = this.p5.constructor.Vector.div(
          prevVelocityPosition,
          this.gridSize
        )
        this.velocities[this.getIndex(i, j)] = this.calculateLerpPrevVelocity(
          prevVelocityRef.x,
          prevVelocityRef.y
        )
      }
    }
    for (let i = 0; i < this.numColumn; i++) {
      for (let j = 0; j < this.numRow; j++) {
        this.prevVelocities[this.getIndex(i, j)] =
          this.velocities[this.getIndex(i, j)].copy()
      }
    }
  }

  updateDiffusion() {
    for (let i = 0; i < this.numColumn; i++) {
      for (let j = 0; j < this.numRow; j++) {
        // Explicit way
        // h = dx = dy = rectSize
        // Dynamic and kinematic viscosity [nu]
        // surroundRatio = nu * dt / (h * h)
        const surroundRatio = 0.2 // 0 - 0.25
        const centerRatio = 1 - 4 * surroundRatio
        // or you can define this way
        // float centerRatio = 0.2; // 0 - 1
        // float surroundRatio = (1 - centerRatio) / 4.0;
        const leftVelocity = this.getPrevVelocity(i - 1, j)
        const rightVelocity = this.getPrevVelocity(i + 1, j)
        const topVelocity = this.getPrevVelocity(i, j - 1)
        const bottomVelocity = this.getPrevVelocity(i, j + 1)
        const total = this.p5.constructor.Vector.add(
          leftVelocity,
          rightVelocity
        )
          .add(topVelocity)
          .add(bottomVelocity)
        this.velocities[this.getIndex(i, j)] = this.p5.constructor.Vector.mult(
          this.prevVelocities[this.getIndex(i, j)],
          centerRatio
        ).add(total.mult(surroundRatio))
      }
    }
    for (let i = 0; i < this.numColumn; i++) {
      for (let j = 0; j < this.numRow; j++) {
        this.prevVelocities[this.getIndex(i, j)] =
          this.velocities[this.getIndex(i, j)].copy()
      }
    }
  }

  updatePressure() {
    // Incompressible
    // TODO: case of boundary
    // SOR (Successive over-relaxation)
    let numSorRepeat = 3
    const sorRelaxationFactor = 1.0 // should more than 1
    // h = dx = dy = rectSize
    // Density [rho]
    // poissonCoef = h * rho / dt
    const poissonCoef = 0.1
    for (let k = 0; k < numSorRepeat; k++) {
      for (let i = 0; i < this.numColumn; i++) {
        for (let j = 0; j < this.numRow; j++) {
          this.pressures[this.getIndex(i, j)] =
            (1 - sorRelaxationFactor) * this.getPrevPressure(i, j) +
            sorRelaxationFactor *
              this.calculatePoissonsEquation(i, j, poissonCoef)
        }
      }
      for (let i = 0; i < this.numColumn; i++) {
        for (let j = 0; j < this.numRow; j++) {
          this.prevPressures[this.getIndex(i, j)] =
            this.pressures[this.getIndex(i, j)]
        }
      }
    }
    for (let i = 0; i < this.numColumn; i++) {
      for (let j = 0; j < this.numRow; j++) {
        const leftPressure = this.getPrevPressure(i - 1, j)
        const rightPressure = this.getPrevPressure(i + 1, j)
        const topPressure = this.getPrevPressure(i, j - 1)
        const bottomPressure = this.getPrevPressure(i, j + 1)
        this.velocities[this.getIndex(i, j)] = this.p5.constructor.Vector.add(
          this.prevVelocities[this.getIndex(i, j)],
          this.p5
            .createVector(
              leftPressure - rightPressure,
              topPressure - bottomPressure
            )
            .div(poissonCoef)
        )
      }
    }
    for (let i = 0; i < this.numColumn; i++) {
      for (let j = 0; j < this.numRow; j++) {
        this.prevVelocities[this.getIndex(i, j)] =
          this.velocities[this.getIndex(i, j)].copy()
      }
    }
  }

  getIndex = (column, row) => row * this.numColumn + column

  generateVelocityPosition = (column, row) => {
    return this.p5.createVector(column, row).add(0.5, 0.5).mult(this.gridSize)
  }

  getPrevVelocity = (column, row) => {
    if (
      column < 0 ||
      column >= this.numColumn ||
      row < 0 ||
      row >= this.numRow
    ) {
      return this.p5.createVector(0, 0)
    }
    return this.prevVelocities[this.getIndex(column, row)]
  }

  getPrevPressure = (column, row) => {
    if (
      column < 0 ||
      column >= this.numColumn ||
      row < 0 ||
      row >= this.numRow
    ) {
      return 0.0
    }
    return this.prevPressures[this.getIndex(column, row)]
  }

  calculateLerpPrevVelocityP = position => {
    const prevVelocityRef = this.p5.constructor.Vector.div(
      position,
      this.gridSize
    )
    return this.calculateLerpPrevVelocity(prevVelocityRef.x, prevVelocityRef.y)
  }

  calculateLerpPrevVelocity = (column, row) => {
    const left = this.p5.floor(column)
    const top = this.p5.floor(row)
    const right = left + 1
    const bottom = top + 1
    const topLerp = this.p5.constructor.Vector.lerp(
      this.getPrevVelocity(left, top),
      this.getPrevVelocity(right, top),
      column - left
    )
    const bottomLerp = this.p5.constructor.Vector.lerp(
      this.getPrevVelocity(left, bottom),
      this.getPrevVelocity(right, bottom),
      column - left
    )
    return this.p5.constructor.Vector.lerp(topLerp, bottomLerp, row - top)
  }

  calculatePoissonsEquation = (column, row, poissonCoef) => {
    // PVector centerVelocity = this.getPrevVelocity(i, j);
    const leftVelocity = this.getPrevVelocity(column - 1, row)
    const rightVelocity = this.getPrevVelocity(column + 1, row)
    const topVelocity = this.getPrevVelocity(column, row - 1)
    const bottomVelocity = this.getPrevVelocity(column, row + 1)
    const divVelocity =
      poissonCoef *
      (rightVelocity.x - leftVelocity.x + bottomVelocity.y - topVelocity.y)
    const leftPressure = this.getPrevPressure(column - 1, row)
    const rightPressure = this.getPrevPressure(column + 1, row)
    const topPressure = this.getPrevPressure(column, row - 1)
    const bottomPressure = this.getPrevPressure(column, row + 1)
    return (
      (leftPressure +
        rightPressure +
        topPressure +
        bottomPressure -
        divVelocity) /
      4.0
    )
  }

  addLerpVelocity = (position, velocity) => {
    const velocityRef = this.p5.constructor.Vector.div(
      position,
      this.gridSize
    ).sub(0.5, 0.5)
    const left = this.p5.floor(velocityRef.x)
    const top = this.p5.floor(velocityRef.y)
    const alpha = velocityRef.x - left
    const beta = velocityRef.y - top
    this.addVelocity(
      left,
      top,
      this.p5.constructor.Vector.mult(velocity, (1 - alpha) * (1 - beta))
    )
    this.addVelocity(
      left + 1,
      top,
      this.p5.constructor.Vector.mult(velocity, alpha * (1 - beta))
    )
    this.addVelocity(
      left,
      top + 1,
      this.p5.constructor.Vector.mult(velocity, (1 - alpha) * beta)
    )
    this.addVelocity(
      left + 1,
      top + 1,
      this.p5.constructor.Vector.mult(velocity, alpha * beta)
    )
  }

  addVelocity = (column, row, velocity) => {
    if (
      column < 0 ||
      column >= this.numColumn ||
      row < 0 ||
      row >= this.numRow
    ) {
      return
    }
    this.prevVelocities[this.getIndex(column, row)].add(velocity)
  }

  willUpdateParticle = particle => {
    const velocity = this.calculateLerpPrevVelocityP(particle.position)
    particle.velocity = velocity.mult(5)
  }

  didUpdateParticle = particle => {}

  draw = () => {
    for (let i = 0; i < this.numColumn; i++) {
      for (let j = 0; j < this.numRow; j++) {
        this.p5.noStroke()
        this.p5.fill(0)
        const position = this.generateVelocityPosition(i, j)
        const pressure = this.pressures[this.getIndex(i, j)]
        this.p5.ellipse(position.x, position.y, pressure, pressure)
        this.p5.stroke(0)
        this.p5.noFill()
        const velocity = this.prevVelocities[this.getIndex(i, j)]
        this.p5.line(
          position.x,
          position.y,
          position.x + velocity.x * 4,
          position.y + velocity.y * 4
        )
      }
    }
  }
}
