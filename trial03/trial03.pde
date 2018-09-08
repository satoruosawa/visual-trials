void setup() {
  size(1080, 1080);
}

void draw() {
  background(100, 151, 179);
  stroke(0);
  strokeWeight(2);
  drawLines();
  filter(BLUR, 3);

  stroke(255);
  strokeWeight(1);
  drawLines();
}

void drawLines() {
  pushMatrix(); {
    for (int i = 0; i < 200; i++) {
      rotate(i);
      line(100, i * 5, width - 200, i * 5);
    }
  } popMatrix();
}
