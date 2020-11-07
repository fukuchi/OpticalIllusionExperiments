class PoggendorffIllusion {
  final int maxValue = 10;
  int value;
  int lineProjectedLength;
  int endPointX;
  final int barWidth = 100;
  final int barHeight = 340;
  int mode = 0;

  PoggendorffIllusion() {
    setValue(floor(random(-maxValue, maxValue)));
    setMode(0);
  }

  int getValue() {
    return value;
  }

  void setValue(int v) {
    if (v < -maxValue || v > maxValue) return;
    value = v;
    endPointX = v * 3;
  }

  int getMaxValue() {
    return maxValue;
  }

  void setMode(int mode) {
    if (mode >= 0 && mode < 2) {
      this.mode = mode;
      lineProjectedLength = 120 + mode * 60;
    }
  }

  int getMode() {
    return mode;
  }

  void draw() {
    background(255);
    pushMatrix();
    translate(width / 2, (height - barHeight) / 2);
    pushStyle();
    stroke(0);
    strokeWeight(2);
    line(0, barHeight / 2, -lineProjectedLength, 0);
    line(endPointX, barHeight / 2, lineProjectedLength + endPointX, barHeight);
    strokeWeight(1);
    fill(255);
    rect(-barWidth / 2, 0, barWidth, barHeight);
    popMatrix();
    popStyle();
  }

  void keyPressed() {
    if (key == CODED) {
      switch(keyCode) {
      case UP:
      case LEFT:
        setValue(value - 1);
        break;
      case DOWN:
      case RIGHT:
        setValue(value + 1);
        break;
      default:
        break;
      }
    }
  }
}
