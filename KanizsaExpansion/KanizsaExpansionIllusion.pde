class KanizsaExpansionIllusion implements Illusion {
  final int maxValue = 10;
  int value;
  final int rectangleWidthA = 100;
  int rectangleWidthB;
  final int adjacentBarWidth = 100;
  final int adjacentBarHeight = 150;
  int mode;

  KanizsaExpansionIllusion() {
    setMode(0);
    randomize();
  }

  void randomize() {
    setValue(floor(random(-maxValue / 2, maxValue / 2)));
  }

  int getValue() {
    return value;
  }

  void setValue(int v) {
    if (v < -maxValue || v > maxValue) return;
    value = v;
    rectangleWidthB = rectangleWidthA + v * 2;
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
    pg.noStroke();
    pg.pushMatrix();

    pg.translate(pg.width * 2 / 7, pg.height / 2);
    pg.fill(0);
    pg.rect(-rectangleWidthA / 2, -rectangleWidthA, rectangleWidthA, rectangleWidthA * 2);

    pg.translate(pg.width * 3 / 7, 0);
    pg.rect(-rectangleWidthB + rectangleWidthA / 2, -rectangleWidthA, rectangleWidthB, rectangleWidthA * 2);
    if (mode == 0) {
      pg.fill(192);
      pg.rect(rectangleWidthA / 2, -adjacentBarHeight, adjacentBarWidth, adjacentBarHeight * 2);
    }

    pg.popMatrix();
    pg.fill(0);
    pg.text("A", pg.width * 2 / 7, pg.height - 30);
    pg.text("B", pg.width * 5 / 7 + rectangleWidthA / 2, pg.height - 30);

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
    text("Width A: " + rectangleWidthA + " px", 0, 0);
    text("Width B: " + rectangleWidthB + " px", 0, 20);
  }

  void recordCurrentValues(Experiment experiment) {
    experiment.appendResult(mode + 1, rectangleWidthA, rectangleWidthB);
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
