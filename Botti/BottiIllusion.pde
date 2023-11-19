class BottiIllusion implements Illusion {
  final int maxValue = 15;
  int value;
  int shiftY;
  final int areaWidth = 500;
  final int areaHeight = 300;
  final int lineWidth = 180;
  final int shortVectorNum = 18;
  final int shortVectorDX = -2;
  final int shortVectorDY = 20;
  int mode;

  BottiIllusion() {
    randomize();
    setMode(0);
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
    shiftY = v * 3;
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

  void drawFigure(PGraphics pg, int x1, int y1, int x2, int y2) {
    int cx, cy;

    pg.line(x1, y1, x2, y2);
    if (mode == 0) {
      for (int i = 0; i <= shortVectorNum; i++) {
        cx = x1 + (x2 - x1) * i / shortVectorNum;
        cy = y1 + (y2 - y1) * i / shortVectorNum;
        pg.line(cx - shortVectorDX, cy - shortVectorDY, cx + shortVectorDX, cy + shortVectorDY);
      }
    }
  }

  void draw(PGraphics pg) {
    int x1, y1, x2, y2;

    pg.beginDraw();
    pg.background(255);
    pg.pushMatrix();
    pg.translate((pg.width - areaWidth) / 2, (pg.height - areaHeight) / 2);
    pg.pushStyle();
    pg.stroke(0);
    pg.strokeWeight(2);

    x1 = 0;
    y1 = areaHeight;
    x2 = lineWidth;
    y2 = areaHeight - lineWidth * areaHeight / areaWidth;
    drawFigure(pg, x1, y1, x2, y2);
    pg.translate(areaWidth - lineWidth, -(areaWidth - lineWidth) * areaHeight / areaWidth + shiftY);
    drawFigure(pg, x1, y1, x2, y2);

    pg.popMatrix();
    pg.strokeWeight(1);
    pg.fill(255);
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
    text("Shift: " + shiftY + " px", 0, 0);
  }

  void recordCurrentValues(Experiment experiment) {
    experiment.appendResult(mode + 1, 0, shiftY);
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
