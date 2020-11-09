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

  void draw(PGraphics pg) {
    pg.beginDraw();
    pg.background(255);

    pg.pushStyle();
    pg.textAlign(CENTER, CENTER);
    pg.textSize(16);
    pg.strokeWeight(2);

    pg.pushMatrix();
    pg.translate(0, 133);
    pg.stroke(0);
    int endPoint1 = (pg.width - arrowLengthA) / 2;
    int endPoint2 = endPoint1 + arrowLengthA;
    pg.line(endPoint1, 0, endPoint2, 0);
    pg.line(endPoint1, 0, endPoint1 - wingWidth, -wingWidth);
    pg.line(endPoint1, 0, endPoint1 - wingWidth, wingWidth);
    pg.line(endPoint2, 0, endPoint2 + wingWidth, -wingWidth);
    pg.line(endPoint2, 0, endPoint2 + wingWidth, wingWidth);
    pg.noStroke();
    pg.text("A", (pg.width - arrowLengthA) / 2, 30);
    pg.popMatrix();

    pg.pushMatrix();
    pg.translate(0, 266);
    pg.stroke(0);
    endPoint1 = (pg.width - arrowLengthB) / 2;
    endPoint2 = endPoint1 + arrowLengthB;
    pg.line(endPoint1, 0, endPoint2, 0);
    pg.line(endPoint1, 0, endPoint1 + wingWidth, -wingWidth);
    pg.line(endPoint1, 0, endPoint1 + wingWidth, wingWidth);
    pg.line(endPoint2, 0, endPoint2 - wingWidth, -wingWidth);
    pg.line(endPoint2, 0, endPoint2 - wingWidth, wingWidth);
    pg.noStroke();
    pg.text("B", (pg.width - arrowLengthB) / 2, 30);
    pg.popMatrix();

    pg.popStyle();
    pg.endDraw();
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
