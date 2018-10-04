abstract class MutualForce {
  protected Particle particleA;
  protected Particle particleB;

  protected MutualForce(Particle particleA, Particle particleB) {
    this.particleA = particleA;
    this.particleB = particleB;
  }

  public abstract void willUpdateParticles();
  public abstract void didUpdateParticles();
  public abstract void draw();

  public boolean isDead() { return particleA == null || particleB == null; }
}
