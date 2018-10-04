class ParticleSystem {
  private ArrayList<Particle> particles = new ArrayList<Particle>();
  private ArrayList<MutualForce> mutualForces = new ArrayList<MutualForce>();

  public void update() {
    for (Particle p : particles) {
      p.resetForce();
    }

    for (MutualForce m : mutualForces) {
      m.willUpdateParticles();
    }

    Iterator<Particle> particleIterator = particles.iterator();
    while (particleIterator.hasNext()) {
      Particle p = particleIterator.next();
      p.update();
      if (p.isDead()) particleIterator.remove();
    }

    Iterator<MutualForce> mutualForceIterator = mutualForces.iterator();
    while (mutualForceIterator.hasNext()) {
      MutualForce m = mutualForceIterator.next();
      if (m.isDead()) mutualForceIterator.remove();
      m.didUpdateParticles();
    }
  }

  public void draw() {
    for (Particle p : particles) {
      p.draw();
    }
    for (MutualForce m : mutualForces) {
      m.draw();
    }
  }

  public void addParticle(Particle p) { particles.add(p); }
  public Particle getParticle(int index) { return particles.get(index); }
  public void addMutualForce(MutualForce m) { mutualForces.add(m); }
}
