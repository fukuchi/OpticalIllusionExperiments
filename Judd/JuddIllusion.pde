class JuddIllusion implements Illusion {
  final int maxValue = 20;
  int value;
  final int dotXStep = 2;

  final int arrowLength = 300;
  final int wingWidth = 30;
  int mode;

  JuddIllusion() {
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
  }

  int getMaxValue() {
    return maxValue;
  }

  void setMode(int mode) {
    if (mode >= 0 && mode < 2) {
      this.mode = mode;
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
    pg.translate(0, pg.height / 2);
    pg.stroke(0);
    int endPoint1 = (pg.width - arrowLength) / 2;
    int endPoint2 = endPoint1 + arrowLength;
    int dotX = endPoint1 + arrowLength / 2 + value * dotXStep;
    pg.line(endPoint1, 0, endPoint2, 0);
    pg.line(endPoint1, 0, endPoint1 - wingWidth, -wingWidth);
    pg.line(endPoint1, 0, endPoint1 - wingWidth, wingWidth);
    if (mode == 0) {
      pg.line(endPoint2, 0, endPoint2 - wingWidth, -wingWidth);
      pg.line(endPoint2, 0, endPoint2 - wingWidth, wingWidth);
    } else {
      pg.line(endPoint2, 0, endPoint2 + wingWidth, -wingWidth);
      pg.line(endPoint2, 0, endPoint2 + wingWidth, wingWidth);
    }
    pg.line(dotX, -10, dotX, 10);
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
    text("Dot X: " + value * dotXStep + " px", 0, 0);
  }

  void recordCurrentValues(Experiment experiment) {
    experiment.appendResult(mode + 1, 0, value * dotXStep);
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
