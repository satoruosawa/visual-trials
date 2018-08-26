import java.text.SimpleDateFormat;
import java.util.*;

ParticleSystem particleSystem;
BasicField basicField;
AttractionField attractionField;

void setup() {
  size(1080, 1080);
  background(255);

  basicField = new BasicField();
  basicField.friction(0.02);
  attractionField = new AttractionField();
  attractionField.strength(-0.05);
  attractionField.sleshhold(500);
  particleSystem = new ParticleSystem();
  setupRing(color(0, 146, 80, 70));
  setupRing(color(0, 134, 171, 70));
  setupRing(color(164, 197, 32, 70));
}

void setupRing(color springColor) {
  int particleNum = 800;
  int startIndex = particleSystem.getParticleSize();
  for (int i = 0; i < particleNum; i++) {
    Particle p = new Particle();
    p.size(3);
    p.addField(basicField);
    p.addField(attractionField);
    p.position(new PVector(
      width / 2 + 50 * cos(i * TWO_PI / particleNum),
      height / 2 + 50 * sin(i * TWO_PI / particleNum)
    ));
    particleSystem.addParticle(p);
  }
  for (int i = 0; i < particleNum; i++) {
    Particle pA = particleSystem.getParticle(startIndex + i);
    Particle pB = particleSystem.getParticle(startIndex + (i + 1) % particleNum);
    Spring s = new Spring(pA, pB);
    s.springLength(1);
    s.springiness(0.2);
    s.springColor(springColor);
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
    pixels[i] = color(
      255.0 - floor((255.0 - red(c)) * coef),
      255.0 - floor((255.0 - green(c)) * coef),
      255.0 - floor((255.0 - blue(c)) * coef)
    );
  }
  updatePixels();
  update();
  particleSystem.draw();
  saveFrame("frames/######.tif");
}

void keyPressed() {
  if (key == 's') {
    Date date = new Date();
    String dateString = new SimpleDateFormat("yyyyMMdd_hhmmss").format(date);
    save(dateString + ".png");
  }
}
