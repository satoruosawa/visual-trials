class Particle {
  private PVector position = new PVector(0, 0);
  private PVector velocity = new PVector(0, 0);
  private PVector force = new PVector(0, 0);
  private float size = 1;
  private float friction = 0.1;

  public void resetForce() { force.set(0, 0); }
  public void addForce(PVector f) { force.add(f); }

  public void update() {
    force.sub(PVector.mult(velocity, friction));
    velocity.add(force);
    position.add(velocity);
  }

  public void draw() {
    noStroke();
    fill(0);
    ellipse(position.x, position.y, size, size);
  }

  public void position(PVector p) { position = p; }
  public void velocity(PVector v) { velocity = v; }
  public void size(float s) { size = s; }
  public void friction(float f) { friction = f; }

  public PVector position() { return position; }
  public PVector velocity() { return velocity; }
  public float size() { return size; }
}
