class VectorField extends Field {
  private ArrayList<PVector> vectors = new ArrayList<PVector>();
  private int fieldRow;
  private int fieldColumn;

  public VectorField() {
    super();
    fieldRow = 10;
    fieldColumn = 10;
    randomForce();
  }

  private void randomForce() {
    for (int j = 0; j < fieldColumn; j++) {
      for (int i = 0; i < fieldRow; i++) {
        PVector v = new PVector(random(-1, 1), random(-1, 1));
        v.mult(0.01);
        vectors.add(v);
      }
    }
  }

  public void willUpdateParticle(Particle particle) {
    int fieldIndexX = int(particle.position().x / width * float(fieldRow - 1));
    int fieldIndexY = int(
      particle.position().y / height * float(fieldColumn - 1)
    );
    if (
      fieldIndexX < 0 ||
      fieldIndexX > fieldRow - 1 ||
      fieldIndexY < 0 ||
      fieldIndexY > fieldColumn - 1
    ) {
      return;
    }
    int fieldIndex = fieldIndexY * fieldRow + fieldIndexX;
    PVector vectorForce = vectors.get(fieldIndex);
    particle.addForce(vectorForce);
  }

  public void didUpdateParticle(Particle particle) {}
}
