import java.util.Iterator;

Grid GRID;
ParticleSystem PARTICLE_SYSTEM = new ParticleSystem();
int RECT_SIZE = 10;

void setup() {
  size(1080, 1080);
  GRID = new Grid(RECT_SIZE, width / RECT_SIZE, height / RECT_SIZE);
  for (int i = 0; i < 100; i++) {
    addParticle();
  }
}

void update() {
  for (int i = 0; i < 100; i++) {
    addParticle();
  }
  GRID.update();
  PARTICLE_SYSTEM.update();
}

void draw() {
  update();
  background(255);
  // GRID.draw();
  PARTICLE_SYSTEM.draw();
  // saveFrame("frames/######.tif");
}

void mouseMoved() {
  PVector diffMouse = new PVector(mouseX - pmouseX, mouseY - pmouseY).mult(10);
  PVector position = new PVector(mouseX, mouseY);
  GRID.addLerpVelocity(position, diffMouse);
}

void addParticle() {
  Particle p = new Particle();
  p.position(new PVector(random(0, width), random(0, height)));
  p.addField(GRID);
  p.life(511);
  p.size(3);
  PARTICLE_SYSTEM.addParticle(p);
}
