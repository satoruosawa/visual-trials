import java.util.Date;

class Ticker {
  private long frameCount = 0;
  public void update() {
    frameCount++;
  }
  public long frameCount() {
    return frameCount;
  }
}
