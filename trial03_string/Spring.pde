class Spring extends MutualForce {
  private float springLength = 1;
  private float springiness = 1;

  public Spring(Particle particleA, Particle particleB) {
    super(particleA, particleB);
  }

  public void updateParticles() {
    PVector posBtoA = PVector.sub(particleA.position(), particleB.position());
    float dist = posBtoA.mag();
    float springForce = (springiness * (springLength - dist));
    posBtoA.normalize();
    particleA.addForce(posBtoA.mult(springForce));
    particleB.addForce(posBtoA.mult(-1.0));
  }

  public void draw() {
    PVector posA = particleA.position();
    PVector posB = particleB.position();
    line(posA.x, posA.y, posB.x, posB.y);
  }

  public void springLength(float s) { springLength = s; }
  public void springiness(float s) { springiness = s; }
}
