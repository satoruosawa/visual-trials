class Grid {
  private int gridSize;
  private int numColumn;
  private int numRow;
  private float[] pressures;
  private PVector[] prevVelocities;
  private PVector[] velocities;

  public Grid(int gridSize, int numColumn, int numRow) {
    this.gridSize = gridSize;
    this.numColumn = numColumn;
    this.numRow = numRow;
    pressures = new float[numColumn * numRow];
    prevVelocities = new PVector[numColumn * numRow];
    velocities = new PVector[numColumn * numRow];
    for (int i = 0; i < numColumn * numRow; i++) {
      prevVelocities[i] = new PVector(0, 0);
      velocities[i] = new PVector(0, 0);
    }
  }

  public void update() {
    updteAdvection();
  }

  private void updteAdvection() {
    for (int i = 0; i < numColumn; i++) {
      for (int j = 0; j < numRow; j++) {
        // semi-Lagrangian
        PVector velocityPosition = new PVector(i, j).mult(gridSize);
        PVector prevVelocityPosition = velocityPosition.sub(prevVelocities[getIndex(i, j)]);
        PVector prevVelocityRef = PVector.div(prevVelocityPosition, gridSize);
        velocities[getIndex(i, j)] = getLerpVelocity(prevVelocityRef.x, prevVelocityRef.y);
      }
    }
    prevVelocities = velocities;
  }

  private int getIndex(int column, int row) {
    return row * numColumn + column;
  }

  private PVector getVelocityPosition(int column, int row) {
    return new PVector(column, row).add(0.5, 0.5).mult(gridSize);
  }

  private PVector getVelocity(int column, int row) {
    if (column < 0 || column >= numColumn || row < 0 || row >= numRow) {
      return new PVector(0, 0);
    }
    return prevVelocities[getIndex(column, row)];
  }

  private PVector getLerpVelocity(float column, float row) {
    int left = floor(column);
    int top = floor(row);
    int right = left + 1;
    int bottom = top + 1;
    PVector topLerp = PVector.lerp(
      getVelocity(left, top), getVelocity(right, top), column - left
    );
    PVector bottomLerp = PVector.lerp(
      getVelocity(left, bottom), getVelocity(right, bottom), column - left
    );
    return PVector.lerp(topLerp, bottomLerp, row - top);
  }

  public void addLerpVelocity(PVector position, PVector velocity) {
    PVector velocityRef = PVector.div(position, gridSize).sub(0.5, 0.5);
    int left = floor(velocityRef.x);
    int top = floor(velocityRef.y);
    float alpha = (velocityRef.x) - left;
    float beta = (velocityRef.y) - top;
    addVelocity(left, top, PVector.mult(velocity, (1 - alpha) * (1 - beta)));
    addVelocity(left + 1, top, PVector.mult(velocity, alpha * (1 - beta)));
    addVelocity(left, top + 1, PVector.mult(velocity, (1 - alpha) * beta));
    addVelocity(left + 1, top + 1, PVector.mult(velocity, alpha * beta));
  }

  private void addVelocity(int column, int row, PVector velocity) {
    if (column < 0 || column >= numColumn || row < 0 || row >= numRow) {
      return;
    }
    prevVelocities[getIndex(column, row)].add(velocity);
  }

  void draw() {
    for (int i = 0; i < numColumn; i++) {
      for (int j = 0; j < numRow; j++) {
        noStroke();
        fill(0);
        PVector position = getVelocityPosition(i, j);
        ellipse(position.x, position.y, 1, 1);
        stroke(0);
        noFill();
        PVector velocity = prevVelocities[getIndex(i, j)];
        line(
          position.x,
          position.y,
          position.x + velocity.x,
          position.y + velocity.y
        );
      }
    }
  }
}
