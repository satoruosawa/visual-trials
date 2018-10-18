import java.util.Iterator;

ParticleSystem particleSystem = new ParticleSystem();
BasicField basicField = new BasicField();
PerlinNoiseField perlinNoiseField = new PerlinNoiseField();

void setup() {
  size(1080, 1080);
  basicField.friction(0.01);
  for (int i = 0; i < 500000; i++) {
    Particle p = new Particle();
    p.position(new PVector(random(0, width), random(0, height)));
    p.addField(perlinNoiseField);
    p.addField(basicField);
    p.size(0.5);
    particleSystem.addParticle(p);
  }
}

void update() {
  particleSystem.update();
}

void draw() {
  update();
  background(255);
  particleSystem.draw();
  saveFrame("frames/######.tif");
}
