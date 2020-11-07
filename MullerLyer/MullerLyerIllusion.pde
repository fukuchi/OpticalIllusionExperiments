class MullerLyerIllusion {
  final int maxValue = 10;
  int value;

  final int arrowLengthA = 300;
  int arrowLengthB;
  int wingWidth;
  int mode;

  MullerLyerIllusion() {
    setValue(floor(random(-maxValue, maxValue)));
    setMode(0);
  }

  int getValue() {
    return value;
  }

  void setValue(int v) {
    if (v < -maxValue || v > maxValue) return;
    value = v;
    arrowLengthB = arrowLengthA + v * 5;
  }

  int getMaxValue() {
    return maxValue;
  }

  void setMode(int mode) {
    if (mode >= 0 && mode < 2) {
      this.mode = mode;
      wingWidth = 30 - mode * 15;
    }
  }

  int getMode() {
    return mode;
  }

  void draw() {
    background(255);

    pushStyle();
    textAlign(CENTER, CENTER);
    textSize(16);

    pushMatrix();
    translate(0, 133);
    stroke(0);
    int endPoint1 = (width - arrowLengthA) / 2;
    int endPoint2 = endPoint1 + arrowLengthA;
    line(endPoint1, 0, endPoint2, 0);
    line(endPoint1, 0, endPoint1 - wingWidth, -wingWidth);
    line(endPoint1, 0, endPoint1 - wingWidth, wingWidth);
    line(endPoint2, 0, endPoint2 + wingWidth, -wingWidth);
    line(endPoint2, 0, endPoint2 + wingWidth, wingWidth);
    noStroke();
    text("A", (width - arrowLengthA) / 2, 30);
    popMatrix();

    pushMatrix();
    translate(0, 266);
    stroke(0);
    endPoint1 = (width - arrowLengthB) / 2;
    endPoint2 = endPoint1 + arrowLengthB;
    line(endPoint1, 0, endPoint2, 0);
    line(endPoint1, 0, endPoint1 + wingWidth, -wingWidth);
    line(endPoint1, 0, endPoint1 + wingWidth, wingWidth);
    line(endPoint2, 0, endPoint2 - wingWidth, -wingWidth);
    line(endPoint2, 0, endPoint2 - wingWidth, wingWidth);
    noStroke();
    text("B", (width - arrowLengthB) / 2, 30);
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
