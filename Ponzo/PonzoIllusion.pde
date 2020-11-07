class PonzoIllusion {
  final int maxValue = 10;
  int value;
  final int radiusA = 80;
  int radiusB;
  final int AX = 240;
  final int BX = 400;
  final float angle = 0.5;
  int mode = 0;

  PonzoIllusion() {
    setValue(floor(random(-maxValue, maxValue)));
  }

  int getValue() {
    return value;
  }

  void setValue(int v) {
    if (v < -maxValue || v > maxValue) return;
    value = v;
    radiusB = radiusA + v * 2;
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
    translate(10, 50);
    pushStyle();
    textAlign(CENTER, CENTER);
    textSize(16);
    stroke(0);
    noFill();
    smooth();

    strokeWeight(2);
    line(0, 0, width, 0);
    if (mode > 0) {
      line(0, 200, width, 200);
    } else {
      line(0, 0, cos(angle) * width, sin(angle) * width);
    }

    ellipse(cos(angle / 2) * AX, sin(angle / 2) * AX, radiusA, radiusA);
    fill(0);
    noStroke();
    text("A", cos(angle / 2) * AX, -20);

    stroke(0);
    noFill();
    ellipse(cos(angle / 2) * BX, sin(angle / 2) * BX, radiusB, radiusB);
    fill(0);
    noStroke();
    text("B", cos(angle / 2) * BX, -20);

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
