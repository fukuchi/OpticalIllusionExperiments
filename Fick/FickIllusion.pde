class FickIllusion {
  final int maxValue = 10;
  int value;
  final int barThickness = 40;
  final int barLengthA = 250;
  int barLengthB;
  int mode = 0;

  FickIllusion() {
    setValue(floor(random(-maxValue, maxValue)));
  }

  int getValue() {
    return value;
  }

  void setValue(int v) {
    if (v < -maxValue || v > maxValue) return;
    value = v;
    barLengthB = barLengthA + v * 5;
  }

  int getMaxValue() {
    return maxValue;
  }

  void setMode(int mode) {
    this.mode = mode;
  }

  int getMode() {
    return mode;
  }

  void draw() {
    background(255);
    pushMatrix();
    translate(0, 50);

    pushStyle();
    textAlign(CENTER, CENTER);
    textSize(16);

    fill(255);
    stroke(0);
    rect((width - barLengthA) / 2, 0, barLengthA, barThickness);
    fill(0);
    noStroke();
    text("A", (width - barLengthA) / 2 + 10, barThickness / 2);

    fill(255);
    stroke(0);
    pushMatrix();
    if (mode > 0) {
      translate((width + barLengthA) / 2 + barThickness / 2, barThickness);
    } else {
      translate(width / 2, barThickness);
    }
    rect(-barThickness / 2, 0, barThickness, barLengthB);
    fill(0);
    noStroke();
    text("B", 0, 20);
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
