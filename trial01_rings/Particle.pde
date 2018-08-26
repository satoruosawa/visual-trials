class Particle {
  private ArrayList<Field> fields = new ArrayList<Field>();
  private PVector position = new PVector(0, 0);
  private PVector velocity = new PVector(0, 0);
  private PVector force = new PVector(0, 0);
  private float size = 1;

  public void resetForce() { force.set(0, 0); }
  public void addForce(PVector f) { force.add(f); }
  public void addField(Field f) { fields.add(f); }

  public void update() {
    for (Field f : fields) {
      f.willUpdateParticle(this);
    }
    updatePosition();
    for (Field f : fields) {
      f.didUpdateParticle(this);
    }
  }

  protected void updatePosition() {
    velocity.add(force);
    position.add(velocity);
  }

  public void draw() {}

  public void position(PVector p) { position = p; }
  public void velocity(PVector v) { velocity = v; }
  public void size(float s) { size = s; }

  public PVector position() { return position; }
  public PVector velocity() { return velocity; }
  public float size() { return size; }
}
