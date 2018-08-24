import java.text.SimpleDateFormat;
import java.util.*;

ParticleSystem particleSystem;

void setup() {
  size(1080, 1080);
  particleSystem = new ParticleSystem();

  int particleNum = 50;
  for (int i = 0; i < particleNum; i++) {
    Particle p = new Particle();
    p.size(3);
    p.friction(0.01);
    p.position(new PVector(
      width / 2 + 400 * cos(i * TWO_PI / particleNum),
      height / 2 + 400 * sin(i * TWO_PI / particleNum)
    ));
    particleSystem.addParticle(p);
  }
  for (int i = 0; i < particleNum; i++) {
    Particle pA = particleSystem.getParticle(i);
    Particle pB = particleSystem.getParticle((i + 1) % particleNum);
    Spring s = new Spring(pA, pB);
    s.springLength(30);
    s.springiness(0.1);
    particleSystem.addSpring(s);
  }
}

void update() {
  particleSystem.update();
}

void draw() {
  background(255);
  // noStroke();
  // fill(255, 1);
  // rect(0, 0, width, height);
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
