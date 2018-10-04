class Spring extends MutualForce {
  private float springLength = 1;
  private float springiness = 1;

  public Spring(Particle particleA, Particle particleB) {
    super(particleA, particleB);
  }

  public void willUpdateParticles() {
    PVector positionAfromB = PVector.sub(
      particleA.position(),
      particleB.position()
    );
    float distance = positionAfromB.mag();
    float springForce = (springiness * (springLength - distance));
    positionAfromB.normalize();
    particleA.addForce(positionAfromB.mult(springForce));
    particleB.addForce(positionAfromB.mult(-1.0));
  }

  public void didUpdateParticles() {
  }

  public void draw() {
    noFill();
    stroke(0);
    PVector pA = particleA.position();
    PVector pB = particleB.position();
    line(pA.x, pA.y, pB.x, pB.y);
  }

  public void springLength(float s) { springLength = s; }
  public void springiness(float s) { springiness = s; }
}
