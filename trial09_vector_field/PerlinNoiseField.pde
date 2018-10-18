class PerlinNoiseField extends Field {
  private float noiseScale = 0.002;
  private float noiseIntensity = 0.05;

  public void willUpdateParticle(Particle particle) {
    float refX = particle.position().x * noiseScale;
    float refY = particle.position().y * noiseScale;
    PVector vectorForce = new PVector(
      calculateNoise(refX, refY),
      calculateNoise(refX + 200, refY)
    );
    particle.addForce(vectorForce);
    particle.addForce(new PVector(0.05, 0));
  }

  private float calculateNoise(float x, float y) {
    float noiseValue = noise(x, y);
    noiseValue = noiseValue * 2.0 - 1.0;
    return noiseValue * noiseIntensity;
  }

  public void didUpdateParticle(Particle particle) {}
}
