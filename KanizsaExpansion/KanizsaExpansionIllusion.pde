class KanizsaExpansionIllusion {
  final int maxValue = 10;
  int value;
  final int rectangleWidthA = 100;
  int rectangleWidthB;
  final int adjacentBarWidth = 100;
  final int adjacentBarHeight = 150;
  int mode = 0;

  KanizsaExpansionIllusion() {
    setValue(floor(random(-maxValue, maxValue)));
    setMode(0);
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
    pg.fill(192);
    pg.rect(rectangleWidthA / 2, -adjacentBarHeight, adjacentBarWidth, adjacentBarHeight * 2);

    pg.popMatrix();
    pg.fill(0);
    pg.text("A", pg.width * 2 / 7, pg.height - 30);
    pg.text("B", pg.width * 5 / 7 + rectangleWidthA / 2, pg.height - 30);

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
