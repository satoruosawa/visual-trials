class ParticleSystem {
  private ArrayList<Particle> particles = new ArrayList<Particle>();

  public void update() {
    for (Particle p : particles) {
      p.resetForce();
      p.update();
    }
  }

  public void draw() {
    for (Particle p : particles) {
      p.draw();
    }
  }

  public void addParticle(Particle p) { particles.add(p); }

  public Particle getParticle(int i) { return particles.get(i); }
  public int getParticleSize() { return particles.size(); }
}
