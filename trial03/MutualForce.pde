abstract class MutualForce {
  protected Particle particleA;
  protected Particle particleB;
  private boolean isDead = false;

  protected MutualForce(Particle particleA, Particle particleB) {
    this.particleA = particleA;
    this.particleB = particleB;
  }

  public void update() {
    if (particleA == null || particleB == null) {
      isDead = true;
      return;
    }
    updateParticles();
  }

  public abstract void updateParticles();
  public abstract void draw();

  public boolean isDead() { return isDead; }
}
