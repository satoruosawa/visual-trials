class FluidField {
  // (0, 0) ... (0, numColumn)
  // ...
  // (numRow, 0) ... (numRow, numColumn)
  private int numRow = 108;
  private int numColumn = 108;
  private float[] fluidVelocityArray;
  private float[] fluidHeightArray;
  private float[] prevFluidHeightArray;

  public FluidField() {
    fluidVelocityArray = new float[numRow * numColumn];
    fluidHeightArray = new float[numRow * numColumn];
    prevFluidHeightArray = new float[numRow * numColumn];
    fluidHeightArray[501] = 1.0;
  }

  public void update() {
    for (int i = 0; i < numRow * numColumn; i++) {
      if (getRow(i) == 0 || getRow(i) == numRow - 1 ||
        getColumn(i) == 0 || getColumn(i) == numColumn - 1) {
        continue;
      }
      int leftIndex = i - 1;
      int rightIndex = i + 1;
      int bottomIndex = i + numColumn;
      int topIndex = i - numColumn;
      float averageHeight = (
        prevFluidHeightArray[leftIndex] +
        prevFluidHeightArray[rightIndex] +
        prevFluidHeightArray[bottomIndex] +
        prevFluidHeightArray[topIndex]
      ) / 4.0;
      float force = (averageHeight - prevFluidHeightArray[i]) * 0.1;
      force += -fluidVelocityArray[i] * 0.05;
      fluidVelocityArray[i] += force;
      fluidHeightArray[i] += fluidVelocityArray[i];
    }
    prevFluidHeightArray = fluidHeightArray;
  }

  private int getIndex(int row, int column) {
    return row * numColumn + column;
  }

  private int getRow(int index) {
    return floor(index / numColumn);
  }

  private int getColumn(int index) {
    return index % numColumn;
  }

  public float getHeight(int row, int column) {
    int index = getIndex(row, column);
    return fluidHeightArray[index];
  }

  public void setHeight(int row, int column, float value) {
    int index = getIndex(row, column);
    fluidHeightArray[index] = value;
  }
}
