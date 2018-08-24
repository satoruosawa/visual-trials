class Spring {
  protected Particle particleA;
  protected Particle particleB;
  private float springLength = 1;
  private float springiness = 1;

  public Spring(Particle particleA, Particle particleB) {
    this.particleA = particleA;
    this.particleB = particleB;
  }

  public void update() {
    PVector posBtoA = PVector.sub(particleA.position(), particleB.position());
    float distance = posBtoA.mag();
    float springForce = (springiness * (springLength - distance));
    posBtoA.normalize();
    particleA.addForce(posBtoA.mult(springForce));
    particleB.addForce(posBtoA.mult(-1.0));
  }

  public void draw() {
    noFill();
    stroke(0);
    PVector posA = particleA.position();
    PVector posB = particleB.position();
    line(posA.x, posA.y, posB.x, posB.y);
  }

  public void springLength(float s) { springLength = s; }
  public void springiness(float s) { springiness = s; }
}
