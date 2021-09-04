import java.text.SimpleDateFormat;
import java.util.*;

void setup() {
  size(1000, 1000);
  background(0);
  noFill();
  strokeWeight(0.05);
  stroke(255);
}

void draw() {
  beginShape();
  float angle1 = random(TWO_PI);
  float r1 = random(width / sqrt(2));
  float angle2 = random(TWO_PI);
  float r2 = random(width / sqrt(2));
  vertex(width / 2 + r1 * cos(angle1), height / 2 + r1 * sin(angle1));
  vertex(width / 2 + r2 * cos(angle2), height / 2 + r2 * sin(angle2));
  // vertex(random(width), random(height));
  // vertex(random(width), random(height));
  endShape();
  saveFrame("frames/######.tif");
}

void keyPressed() {
  if (key == 's') {
    Date date = new Date();
    String dateString = new SimpleDateFormat("yyyyMMdd_hhmmss").format(date);
    save(dateString + ".png");
  }
}
