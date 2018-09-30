class BasicField extends Field {
  private float friction;
  private WallBehavior wallBehavior;
  private float cor;

  public BasicField() {
    super();
    wallBehavior = WallBehavior.ORIGINAL;
    friction = 0.01;
    cor = 1;
  }

  public void willUpdateParticle(Particle particle) {
    particle.addForce(PVector.mult(particle.velocity(), -friction));
  }

  public void didUpdateParticle(Particle particle) {
    wallBehavior(particle);
  }

  public void wallBehavior(Particle particle) {
    switch (wallBehavior) {
      case BOUNCE:
        bounceOfWalls(particle);
        break;
      case THROUGH:
        throughOfWalls(particle);
        break;
      case ORIGINAL:
        original(particle);
        break;
    }
  }

  private void bounceOfWalls(Particle particle) {
    float xmin = 0 + particle.size() / 2;
    float xmax = width - particle.size() / 2;
    float ymin = 0 + particle.size() / 2;
    float ymax = height - particle.size() / 2;
    PVector pos = particle.position();
    PVector vel = particle.velocity();
    if (pos.x < xmin) {
      pos.x = xmin + (xmin - pos.x);
      vel.x *= -cor;
    } else if (pos.x > xmax) {
      pos.x = xmax - (pos.x - xmax);
      vel.x *= -cor;
    }
    if (pos.y < ymin) {
      pos.y = ymin + (ymin - pos.y);
      vel.y *= -cor;
    } else if (pos.y > ymax) {
      pos.y = ymax - (pos.y - ymax);
      vel.y *= -cor;
    }
  }

  private void throughOfWalls(Particle particle) {
    float xmin = 0 - particle.size() / 2;
    float xmax = width + particle.size() / 2;
    float ymin = 0 - particle.size() / 2;
    float ymax = height + particle.size() / 2;
    float shiftWidth = width + particle.size();
    float shiftHeight = width + particle.size();
    PVector pos = particle.position();
    PVector vel = particle.velocity();
    if (pos.x < xmin) {
      pos.x += shiftWidth;
    } else if (pos.x > xmax) {
      pos.x -= shiftWidth;
    }
    if (pos.y < ymin) {
      pos.y += shiftHeight;
    } else if (pos.y > ymax) {
      pos.y -= shiftHeight;
    }
  }

  private void original(Particle particle) {
    float raduis = 50.0;
    PVector pos = particle.position();
    PVector center = new PVector(width / 2, height * 2 / 3);
    PVector posFromCenter = PVector.sub(pos, center);
    if (posFromCenter.mag() < raduis) {
      posFromCenter.setMag(raduis);
      pos.x = posFromCenter.x + center.x;
      pos.y = posFromCenter.y + center.y;
    }
  }

  public void friction(float f) { friction = f; }
  public void cor(float c) { cor = c; }
}

enum WallBehavior {
  BOUNCE,
  THROUGH,
  ORIGINAL
};
