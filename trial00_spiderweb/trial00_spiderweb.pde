import java.text.SimpleDateFormat;
import java.util.*;

void setup() {
  size(1080, 1080);
  background(0);
	noFill();
	strokeWeight(0.05);
  stroke(255);
}

void draw() {
  beginShape();
  vertex(random(width), random(height));
  vertex(random(width), random(height));
  endShape();
}

void keyPressed() {
  if (key == 's') {
    Date date = new Date();
    String dateString = new SimpleDateFormat("yyyyMMdd_hhmmss").format(date);
    save(dateString + ".png");
  }
}
