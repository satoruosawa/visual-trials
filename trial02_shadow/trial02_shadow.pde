import java.text.SimpleDateFormat;
import java.util.*;

PShader V_BLUR;
PShader H_BLUR;
PShader OVERLAY;
PShader SHIFT;
PGraphics PG;
ParticleSystem PARTICLE_SYSTEM;
int FRAME_COUNT = 0;

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

  BasicField basicField = new BasicField();
  PARTICLE_SYSTEM = new ParticleSystem();
  int particleNum = 100;
  for (int i = 0; i < particleNum; i++) {
    Particle p = new Particle();
    p.size(random(10, 100));
    p.addField(basicField);
    p.position(new PVector(
      width / 2 + 500 * cos(i * TWO_PI / particleNum),
      height / 2 + 500 * sin(i * TWO_PI / particleNum)
    ));
    p.velocity(new PVector(
      random(-1, 1), random(-1, 1)
    ));
    PARTICLE_SYSTEM.addParticle(p);
  }
}

void update() {
  float elevation = 2 + 5 * (1 + sin(TWO_PI * FRAME_COUNT / 60.0 / 3.0));
  V_BLUR.set("amount", int(elevation));
  H_BLUR.set("amount", int(elevation));
  SHIFT.set("amount", new PVector(elevation / 5, elevation / 5));
  FRAME_COUNT++;

  PARTICLE_SYSTEM.update();
}

void draw() {
  update();
  PG.beginDraw(); {
    PG.background(178, 174, 164);
  } PG.endDraw();
  PARTICLE_SYSTEM.draw();
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
  saveFrame("frames/######.tif");
}

void keyPressed() {
  if (key == 's') {
    Date date = new Date();
    String dateString = new SimpleDateFormat("yyyyMMdd_hhmmss").format(date);
    save(dateString + ".png");
  }
}
