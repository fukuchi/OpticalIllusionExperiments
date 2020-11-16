class OppelKundtIllusion implements Illusion {
  final int maxValue = 15;
  int value;
  final int intervalA = 200;
  int intervalB;
  final int stimulusNum = 7;
  final int stimuliLength = 40;
  int mode;

  OppelKundtIllusion() {
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
    intervalB = intervalA + v * 3;
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
    pg.pushMatrix();
    pg.translate((pg.width - intervalA * 2) / 2, (pg.height - stimuliLength) / 2);

    pg.pushStyle();
    pg.textAlign(CENTER, CENTER);
    pg.textSize(16);
    pg.stroke(0);
    pg.fill(0);
    pg.smooth();

    pg.line(        0, 0, 0, stimuliLength);
    pg.line(intervalA, 0, intervalA, stimuliLength);
    pg.line(intervalA + intervalB, 0, intervalA + intervalB, stimuliLength);
    pg.text("A", 0, -20);
    pg.text("B", intervalA, -20);
    pg.text("C", intervalA + intervalB, -20);
    if (mode == 0) {
      for (int i=0; i<stimulusNum; i++) {
        int x = (i + 1) * intervalA / (stimulusNum + 1);
        pg.line(x, 0, x, stimuliLength);
      }
    }

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
    text("Interval A: " + intervalA + " px", 0, 0);
    text("Interval B: " + intervalB + " px", 0, 20);
  }

  void recordCurrentValues(Experiment experiment) {
    experiment.appendResult(mode + 1, intervalA, intervalB);
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
