ParticleSystem PS = new ParticleSystem();

void setup() {
  size(1080, 1080);

  int particleNum = 200;
  BasicField basicField = new BasicField();
  basicField.friction(0.005);
  for (int i = 0; i < particleNum; i++) {
    Particle p = new Particle();
    p.size(3);
    p.addField(basicField);
    p.position(new PVector(
      width / 2 + 500 * cos(i * TWO_PI / particleNum),
      height / 2 + 500 * sin(i * TWO_PI / particleNum)
    ));
    PS.addParticle(p);
  }
  for (int i = 0; i < particleNum - 1; i++) {
    Particle pA = PS.getParticle(i);
    Particle pB = PS.getParticle(i + 1);
    Spring s = new Spring(pA, pB);
    s.springLength(3);
    s.springiness(0.2);
    PS.addMutualForce(s);
  }
}

void update() {
  PS.update();
}

void draw() {
  update();
  background(100, 151, 179);
  stroke(0);
  strokeWeight(2);
  PS.draw();
  filter(BLUR, 3);

  stroke(255);
  strokeWeight(1);
  PS.draw();
  saveFrame("frames/######.tif");
}
