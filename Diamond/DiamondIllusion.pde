class DiamondIllusion implements Illusion {
  final int maxValue = 10;
  int value;
  final int widthA = 150;
  int widthB;
  int mode;

  DiamondIllusion() {
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
    widthB = widthA + v * 4;
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
    pg.smooth();
    pg.strokeWeight(2);

    pg.pushMatrix();
    pg.translate(pg.width *2 / 7, pg.height / 2);
    pg.noStroke();
    pg.fill(0);
    pg.text("A", 0, 30 - pg.height / 2);
    pg.stroke(0);
    pg.noFill();
    pg.rect(-widthA / 2, -widthA / 2, widthA, widthA);
    pg.popMatrix();

    pg.pushMatrix();
    pg.translate(pg.width * 5 / 7, pg.height / 2);
    pg.noStroke();
    pg.fill(0);
    pg.text("B", 0, 30 - pg.height / 2);
    pg.stroke(0);
    pg.noFill();
    pg.rotate(HALF_PI / 4 + HALF_PI / 4 * (1 - mode));
    pg.rect(-widthB / 2, -widthB / 2, widthB, widthB);
    pg.popMatrix();

    pg.popStyle();
    if (showHashCode) {
      String hash = String.format("%08x", String.format("%s-%02d%02d-meaningless-string", title, mode, value).hashCode());
      pg.textSize(12);
      pg.noStroke();
      pg.fill(0);
      pg.textAlign(LEFT, TOP);
      pg.text(hash, 0, 0);
    }
    pg.endDraw();
  }

  void drawParameters() {
    textAlign(LEFT, TOP);
    fill(0);
    stroke(0);
    text("Length A: " + widthA + " px", 0, 0);
    text("Length B: " + widthB + " px", 0, 20);
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
