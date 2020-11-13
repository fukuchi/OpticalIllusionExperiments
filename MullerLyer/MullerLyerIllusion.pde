class MullerLyerIllusion implements Illusion {
  final int maxValue = 10;
  int value;

  final int arrowLengthA = 300;
  int arrowLengthB;
  int wingWidth;
  int mode;

  MullerLyerIllusion() {
    setValue(floor(random(-maxValue, maxValue)));
    setMode(0);
    randomize();
  }

  void randomize() {
    setValue(floor(random(-maxValue, maxValue)));
  }

  int getValue() {
    return value;
  }

  void setValue(int v) {
    if (v < -maxValue || v > maxValue) return;
    value = v;
    arrowLengthB = arrowLengthA + v * 4;
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
    pg.popMatrix();

    if (showHashCode) {
      String hash = String.format("%08x", String.format("%s-%02d%02d-meaningless-string", title, mode, value).hashCode());
      pg.textSize(12);
      pg.noStroke();
      pg.fill(0);
      pg.textAlign(LEFT, TOP);
      pg.text(hash, 0, 0);
    }
    pg.popStyle();
    pg.endDraw();
  }

  void drawParameters() {
    textAlign(LEFT, TOP);
    fill(0);
    stroke(0);
    text("Length A: " + arrowLengthA + " px", 0, 0);
    text("Length B: " + arrowLengthB + " px", 0, 20);
  }

  void recordCurrentValues(Experiment experiment) {
    experiment.appendResult(mode + 1, arrowLengthA, arrowLengthB);
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
