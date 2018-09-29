import java.text.SimpleDateFormat;
import java.util.*;

void setup() {
  size(1080, 1080);
  background(255);
  PImage img;
  img = loadImage("background2.png");
  image(img, 0, 0);
	noFill();
	strokeWeight(0.05);
}

void draw() {
  pushMatrix(); {
    translate(width / 2, height / 2);
    float radius = 300.0 + randomGaussian() * 30.0;
    float angle = randomGaussian();
    float x = radius * cos(angle);
    float y = radius * sin(angle);
    float size = random(10, 100 / (1 + abs(angle)));
    stroke(0);
    ellipse(x, y, size, size);
  } popMatrix();
}

void keyPressed() {
  if (key == 's') {
    Date date = new Date();
    String dateString = new SimpleDateFormat("yyyyMMdd_hhmmss").format(date);
    save(dateString + ".png");
  }
}
