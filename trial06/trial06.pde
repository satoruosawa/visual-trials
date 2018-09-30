import java.text.SimpleDateFormat;
import java.util.*;

PImage IMAGE;
BasicField BASIC_FIELD = new BasicField();
ParticleSystem PARTICLE_SYSTEM = new ParticleSystem();
VectorField VECTOR_FIELD = new VectorField();

float RADIUS = 50.0;

void setup() {
  size(1080, 1080);
  background(255);
  IMAGE = loadImage("background2.png");
}

void update() {
  for (int i = 0; i < 500; i ++) {
    float angle = random(TWO_PI);
    float radius = random(RADIUS);
    float x = 300 + radius * cos(angle);
    float y = 150 + radius * sin(angle);
    Particle particle = new Particle();
    particle.position(new PVector(x, y));
    particle.addField(BASIC_FIELD);
    particle.addField(VECTOR_FIELD);
    particle.size(0.5);
    PARTICLE_SYSTEM.addParticle(particle);
  }
  PARTICLE_SYSTEM.update();
}

void draw() {
  update();
  image(IMAGE, 0, 0);
  PARTICLE_SYSTEM.draw();
  fill(50);
  noStroke();
  ellipse(300, 150, RADIUS * 2, RADIUS * 2);
  saveFrame("frames/######.tif");
}

void keyPressed() {
  if (key == 's') {
    Date date = new Date();
    String dateString = new SimpleDateFormat("yyyyMMdd_hhmmss").format(date);
    save(dateString + ".png");
  }
}
