import java.text.SimpleDateFormat;
import java.util.*;

ParticleSystem particleSystem;
BasicField basicField;
AttractionField attractionField;

void setup() {
  size(1080, 1080);
  background(0);

  basicField = new BasicField();
  basicField.friction(0.02);
  attractionField = new AttractionField();
  attractionField.strength(-0.1);
  attractionField.sleshhold(500);
  particleSystem = new ParticleSystem();
  int particleNum = 200;
  for (int i = 0; i < particleNum; i++) {
    Particle p = new Particle();
    p.size(3);
    p.addField(basicField);
    p.addField(attractionField);
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
    s.springLength(10);
    s.springiness(0.1);
    particleSystem.addSpring(s);
  }
}

void update() {
  attractionField.position(new PVector(mouseX, mouseY));
  particleSystem.update();
}

void draw() {
  loadPixels();
  for (int i = 0; i < width * height; i++) {
    color c = pixels[i];
    float coef = 0.99;
    pixels[i] = color(red(c) * coef, green(c) * coef, blue(c) * coef);
  }
  updatePixels();
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
