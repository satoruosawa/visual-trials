class ParticleSystem {
  private ArrayList<Particle> particles = new ArrayList<Particle>();
  private ArrayList<Spring> springs = new ArrayList<Spring>();

  public void update() {
    for (Particle p : particles) {
      p.resetForce();
    }

    for (Spring s : springs) {
      s.update();
    }

    for (Particle p : particles) {
      p.update();
    }
  }

  public void draw() {
    for (Particle p : particles) {
      p.draw();
    }
    for (Spring s : springs) {
      s.draw();
    }
  }

  public void addParticle(Particle p) { particles.add(p); }
  public void addSpring(Spring s) { springs.add(s); }

  public Particle getParticle(int i) {
    return particles.get(i);
  }
  public int getParticleSize() { return particles.size(); }
}
