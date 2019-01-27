class Particle {
  private PVector position = new PVector(0, 0);
  private PVector velocity = new PVector(0, 0);
  private PVector force = new PVector(0, 0);
  private float life = 100;
  private float size = 1;

  public void update() {
    updatePosition();
    life -= 1;
  }

  protected void updatePosition() {
    velocity.add(force);
    position.add(velocity);
  }

  public void draw() {
    curveVertex(position.x,  position.y);
  }

  public void resetForce() { force.set(0, 0); }
  public void addForce(PVector f) { force.add(f); }

  public boolean isDead() {
    if (life < 0) {
      return true;
    }
    return false;
  }

  public void position(PVector p) { position = p; }
  public void velocity(PVector v) { velocity = v; }
  public void life(float l) { life = l; }
  public void size(float s) { size = s; }

  public PVector position() { return position; }
  public PVector velocity() { return velocity; }
  public float life() { return life; }
  public float size() { return size; }
}
