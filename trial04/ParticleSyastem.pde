class ParticleSystem {
  private ArrayList<Particle> particles = new ArrayList<Particle>();

  public void update() {
    for (int i = particles.size() - 1; i >= 0; i--) {
      Particle p = particles.get(i);
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
}
