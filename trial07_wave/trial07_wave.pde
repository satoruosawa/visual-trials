import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Iterator;

ParticleSystem PARTICLE_SYSTEM = new ParticleSystem();
BasicField BASIC_FIELD = new BasicField();

int NUM_PARTICLE = 100;
float SPRING_LENGTH = 1;

void setup() {
  size(1080, 1080);
  background(255);
  BASIC_FIELD.friction(0.1);

  for (int i = 0; i < NUM_PARTICLE; i++) {
    Particle particle = new Particle();
    particle.addField(BASIC_FIELD);
    particle.position(new PVector(width / 2 + SPRING_LENGTH * i, height / 2));
    particle.life(10000);
    particle.size(5);
    PARTICLE_SYSTEM.addParticle(particle);
  }
  for (int i = 0; i < NUM_PARTICLE - 1; i++) {
    Spring s = new Spring(
      PARTICLE_SYSTEM.getParticle(i),
      PARTICLE_SYSTEM.getParticle(i + 1)
    );
    s.springLength(SPRING_LENGTH);
    s.springiness(0.9);
    PARTICLE_SYSTEM.addMutualForce(s);
  }
}

void update() {
  PARTICLE_SYSTEM.update();
  PARTICLE_SYSTEM.getParticle(99).position(new PVector(
    width / 2 + SPRING_LENGTH * (NUM_PARTICLE - 1),
    height / 2)
  );
  PARTICLE_SYSTEM.getParticle(0).position(new PVector(mouseX, mouseY));
}

void draw() {
  update();
  background(255);
  PARTICLE_SYSTEM.draw();
}

void keyPressed() {
  if (key == 's') {
    Date date = new Date();
    String dateString = new SimpleDateFormat("yyyyMMdd_hhmmss").format(date);
    save(dateString + ".png");
  }
}
