class AttractionField extends Field {
  private PVector position;
  private float strength;
  private float sleshhold;

  public AttractionField() {
    super();
    position = new PVector(0, 0);
    strength = 1;
    sleshhold = 1;
  }

  public void willUpdateParticle(Particle particle) {
    PVector posToParticle = PVector.sub(particle.position(), position);
    float distance = posToParticle.mag();
    if (distance < sleshhold) {
      float pct = 1 - (distance / sleshhold);
      posToParticle.normalize();
      PVector frcToAdd = posToParticle.mult(-pct * strength);
      frcToAdd.add((new PVector(random(-1, 1), random(-1, 1))).mult(0.1));
      particle.addForce(frcToAdd);
    }
  }

  public void didUpdateParticle(Particle particle) {}

  public void position(PVector p) { position = p; }
  public void strength(float s) { strength = s; }
  public void sleshhold(float s) { sleshhold = s; }
}
