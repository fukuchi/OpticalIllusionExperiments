class HelmholtzIllusion implements Illusion {
  final int maxValue = 10;
  int value;
  final int barWidth = 10;
  final int barNum = 15;
  int widthA, widthB;
  final int shiftY = 50;
  int mode;

  HelmholtzIllusion() {
    widthA = barWidth * barNum;
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
    widthB = widthA + v * 3;
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

  void draw(PGraphics pg) {
    pg.beginDraw();
    pg.background(255);
    pg.pushStyle();
    pg.textAlign(CENTER, CENTER);
    pg.textSize(16);
    pg.pushMatrix();
    pg.translate(0, (pg.height - widthA) / 2);

    pg.noStroke();
    pg.fill(0);
    pg.rect(100, -shiftY, widthA, widthA);
    for (int i=0; i<barNum; i++) {
      if (mode !=0 || i % 2 == 0) {
        pg.rect(pg.width - widthA - 100 + i * barWidth, (widthA - widthB) / 2 + shiftY, barWidth, widthB);
      }
    }
    pg.text("A", 50, widthA / 2 - shiftY);
    pg.text("B", pg.width - 50, widthA / 2 + shiftY);

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
    text("Height A: " + widthA + " px", 0, 0);
    text("Height B: " + widthB + " px", 0, 20);
  }

  void recordCurrentValues(Experiment experiment) {
    experiment.appendResult(mode + 1, widthA, widthB);
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
