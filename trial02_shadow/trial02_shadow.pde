import java.text.SimpleDateFormat;
import java.util.*;

PShader V_BLUR;
PShader H_BLUR;

void setup() {
  size(1080, 1080, P2D);
  background(255);
  frameRate(60);

  V_BLUR = loadShader("blur.glsl");
  V_BLUR.set("textureSize", new PVector(width, height, 0));
  V_BLUR.set("amount", 2.0);
  V_BLUR.set("isVertical", true);
  H_BLUR = loadShader("blur.glsl");
  H_BLUR.set("textureSize", new PVector(width, height, 0));
  H_BLUR.set("amount", 2.0);
  H_BLUR.set("isVertical", false);
}

void draw() {
  background(0);
  fill(255);
  noStroke();
  rect(mouseX, mouseY, 100, 100);
  rect(100, 100, 100, 100);
  V_BLUR.set("sampleTexture", get());
  shader(V_BLUR); {
    rect(0, 0, width, height);
  } resetShader();
  H_BLUR.set("sampleTexture", get());
  shader(H_BLUR); {
    rect(0, 0, width, height);
  } resetShader();
}

void keyPressed() {
  if (key == 's') {
    Date date = new Date();
    String dateString = new SimpleDateFormat("yyyyMMdd_hhmmss").format(date);
    save(dateString + ".png");
  }
}
