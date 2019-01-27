class ParticleSystem {
  private ArrayList<Particle> particles = new ArrayList<Particle>();

  public void update() {
    for (Particle p : particles) {
      p.resetForce();
    }

    Iterator<Particle> particleIterator = particles.iterator();
    while (particleIterator.hasNext()) {
      Particle p = particleIterator.next();
      p.update();
      if (p.isDead()) particleIterator.remove();
    }
  }

  public void draw() {
    for (Particle p : particles) {
      p.draw();
    }
  }

  public void addParticle(Particle p) { particles.add(p); }
  public Particle getParticle(int index) { return particles.get(index); }
}
