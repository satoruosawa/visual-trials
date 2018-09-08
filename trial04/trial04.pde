ParticleSystem particleSystem = new ParticleSystem();
PImage pImage;
PGraphics pGraphics;

void setup() {
  size(1080, 1080);
  background(255);
  pImage = loadImage("./data/texture.png");
  pGraphics = createGraphics(width, height);
  pGraphics.beginDraw(); {
    pGraphics.background(255);
    pGraphics.image(pImage, 0, 0, pGraphics.width, pGraphics.height);
    pGraphics.loadPixels();
    BasicField basicField = new BasicField();
    basicField.friction(0.005);
    AttractionField attractionField = new AttractionField();
    attractionField.strength(-5.);
    attractionField.sleshhold(500);
    attractionField.position(new PVector(0, height));
    for (int j = 0; j < pGraphics.height; j++) {
      for (int i = 0; i < pGraphics.width; i++) {
        color c = pGraphics.pixels[j * pGraphics.width + i];
        if (c != -3289651) {
          Particle p = new Particle();
          p.position(new PVector(i, j));
          p.addField(attractionField);
          p.addField(basicField);
          p.particleColor(c);
          particleSystem.addParticle(p);
        }
      }
    }
  } pGraphics.endDraw();
}

void update() {
  particleSystem.update();
}

void draw() {
  update();
  background(-3289651);
  particleSystem.draw();
  saveFrame("frames/######.tif");
}
