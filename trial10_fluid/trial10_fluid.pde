FluidField fluidField;
int rectSize = 10;

void setup() {
  size(1080, 1080);
  fluidField = new FluidField();
}

void update() {
  fluidField.update();
}

void draw() {
  update();
  background(255);
  for (int i = 0; i < 108; i++) {
    for (int j = 0; j < 108; j++) {
      noStroke();
      fill(fluidField.getHeight(j, i) * 255);
      rect(i * rectSize, j * rectSize, rectSize, rectSize);
    }
  }
  saveFrame("frames/######.tif");
}

void mouseMoved() {
  PVector diffMouse = new PVector(mouseX - pmouseX, mouseY - pmouseY);
  fluidField.setHeight(mouseY / rectSize, mouseX / rectSize, diffMouse.mag() * 0.5);
}
