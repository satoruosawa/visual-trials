import java.util.Iterator;

Grid GRID;
ParticleSystem PARTICLE_SYSTEM = new ParticleSystem();
int RECT_SIZE = 10;
PGraphics P_GRAPHICS;
PFont GARAMOND_450;
Ticker TICKER;

void setup() {
  size(1080, 1080);
  P_GRAPHICS = createGraphics(width, height);
  GARAMOND_450 = createFont("GaramondPremrPro-LtDisp-450.vlw", 450);
  GRID = new Grid(RECT_SIZE, width / RECT_SIZE, height / RECT_SIZE);
  TICKER = new Ticker();
}

void update() {
  TICKER.update();
  if (TICKER.frameCount() % 60 == 0) {
    P_GRAPHICS.beginDraw(); {
      P_GRAPHICS.textFont(GARAMOND_450);
      P_GRAPHICS.background(255);
      P_GRAPHICS.noStroke();
      P_GRAPHICS.fill(0);
      P_GRAPHICS.textAlign(CENTER, CENTER);
      P_GRAPHICS.text(str(int(TICKER.frameCount() / 60)), width / 2, height / 2);
      P_GRAPHICS.loadPixels();
      for (int j = 0; j < P_GRAPHICS.height; j++) {
        for (int i = 0; i < P_GRAPHICS.width; i++) {
          color c = P_GRAPHICS.pixels[j * P_GRAPHICS.width + i];
          if (c != -1) {
            Particle p = new Particle();
            p.position(new PVector(i, j));
            PARTICLE_SYSTEM.addParticle(p);
            p.addField(GRID);
            p.life(100);
          }
        }
      }
    } P_GRAPHICS.endDraw();

  }
  GRID.update();
  PARTICLE_SYSTEM.update();
}

void draw() {
  update();
  background(255);
  // image(P_GRAPHICS, 0, 0);
  // GRID.draw();
  PARTICLE_SYSTEM.draw();
  saveFrame("frames/######.tif");
}

void mouseMoved() {
  PVector diffMouse = new PVector(mouseX - pmouseX, mouseY - pmouseY).mult(2);
  PVector position = new PVector(mouseX, mouseY);
  GRID.addLerpVelocity(position, diffMouse);
}

void addParticle() {
  Particle p = new Particle();
  p.position(new PVector(random(0, width), random(0, height)));
  p.addField(GRID);
  p.life(511);
  p.size(3);
  PARTICLE_SYSTEM.addParticle(p);
}
