import java.text.SimpleDateFormat;
import java.util.*;

ParticleSystem particleSystem;

void setup() {
  size(1080, 1080);
  particleSystem = new ParticleSystem();

  Particle particleA = new Particle();
  particleA.position(new PVector(random(0.0, width), random(0.0, height)));
  Particle particleB = new Particle();
  particleB.position(new PVector(random(0.0, width), random(0.0, height)));
  particleSystem.addParticle(particleA);
  particleSystem.addParticle(particleB);
  Spring spring = new Spring(particleA, particleB);
  spring.springLength(500);
  spring.springiness(0.01);
  particleSystem.addSpring(spring);
}

void update() {
  particleSystem.update();
}

void draw() {
  background(255);
  update();
  particleSystem.draw();
}

void keyPressed() {
  if (key == 's') {
    Date date = new Date();
    String dateString = new SimpleDateFormat("yyyyMMdd_hhmmss").format(date);
    save(dateString + ".png");
  }
}
