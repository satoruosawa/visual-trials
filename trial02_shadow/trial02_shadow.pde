import java.text.SimpleDateFormat;
import java.util.*;

PShader V_BLUR;
PShader H_BLUR;
PShader OVERLAY;
PShader SHIFT;
PGraphics PG;

void setup() {
  size(1080, 1080, P2D);
  background(255);
  frameRate(60);
  PG = createGraphics(width, height, P2D);

  V_BLUR = loadShader("blur.glsl");
  V_BLUR.set("textureSize", new PVector(width, height));
  V_BLUR.set("amount", 10);
  V_BLUR.set("isVertical", true);
  H_BLUR = loadShader("blur.glsl");
  H_BLUR.set("textureSize", new PVector(width, height));
  H_BLUR.set("amount", 10);
  H_BLUR.set("isVertical", false);
  SHIFT = loadShader("shift.glsl");
  SHIFT.set("textureSize", new PVector(width, height));
  SHIFT.set("amount", new PVector(3, 3));
  OVERLAY = loadShader("overlay.glsl");
  OVERLAY.set("textureSize", new PVector(width, height));
}

void draw() {
  PG.beginDraw(); {
    PG.background(0);
    PG.fill(178, 174, 164);
    PG.noStroke();
    PG.rect(mouseX, mouseY, 100, 100, 10);
  } PG.endDraw();
  V_BLUR.set("sampleTexture", PG.get());
  shader(V_BLUR); {
    rect(0, 0, width, height);
  } resetShader();
  H_BLUR.set("sampleTexture", get());
  shader(H_BLUR); {
    rect(0, 0, width, height);
  } resetShader();
  SHIFT.set("sampleTexture", get());
  shader(SHIFT); {
    rect(0, 0, width, height);
  } resetShader();
  OVERLAY.set("baseTexture", get());
  OVERLAY.set("overlayTexture", PG.get());
  shader(OVERLAY); {
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
