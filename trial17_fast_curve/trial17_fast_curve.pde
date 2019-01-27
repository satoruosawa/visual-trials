import java.text.SimpleDateFormat;
import java.util.*;

ParticleSystem PARTICLE_SYSTEM = new ParticleSystem();

void setup() {
  size(1080, 1080);
  background(255);
}

void update() {
  PVector basePosition = new PVector(random(0, width), random(0, height));
  PVector baseVelocity = new PVector(random(-1, 1), random(-1, 1));
  for (int i = 0; i < 3; i++) {
    Particle p = new Particle();
    float diffPosition = 50;
    PVector psition = new PVector(
      random(-diffPosition, diffPosition), random(-diffPosition, diffPosition));
    psition.add(basePosition);
    p.position(psition);
    float diffVelocity = 0.1;
    PVector velocity = new PVector(
      random(-diffVelocity, diffVelocity), random(-diffVelocity, diffVelocity));
    velocity.add(baseVelocity);
    p.velocity(velocity);
    PARTICLE_SYSTEM.addParticle(p);
  }

  PARTICLE_SYSTEM.update();
}

void draw() {
  update();
  fill(255, 10);
  rect(0, 0, width, height);
	noFill();
	strokeWeight(0.05);
  stroke(0);
  beginShape();
  PARTICLE_SYSTEM.draw();
  endShape();
  // saveFrame("frames/######.tif");
}

void keyPressed() {
  if (key == 's') {
    Date date = new Date();
    String dateString = new SimpleDateFormat("yyyyMMdd_hhmmss").format(date);
    save(dateString + ".png");
  }
}
