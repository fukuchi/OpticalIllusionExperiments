class DelboeufIllusion implements Illusion {
  final int maxValue = 10;
  int value;
  final int radiusA = 60;
  int radiusB;
  final int outerRadiusL = 120;
  final int outerRadiusS = 70;
  int mode;

  DelboeufIllusion() {
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
    radiusB = radiusA + v * 2;
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
    pg.translate(0, pg.height / 2);

    pg.noFill();
    pg.stroke(0);
    pg.strokeWeight(2);
    if (mode == 0) {
      pg.ellipse(pg.width * 2 / 7, 0, outerRadiusL * 2, outerRadiusL * 2);
    } else {
      pg.ellipse(pg.width * 2 / 7, 0, outerRadiusS * 2, outerRadiusS * 2);
    }
    pg.fill(0);
    pg.noStroke();
    pg.ellipse(pg.width * 2 / 7, 0, radiusA * 2, radiusA * 2);
    pg.ellipse(pg.width * 5 / 7, 0, radiusB * 2, radiusB * 2);

    pg.text("A", pg.width * 2 / 7, pg.height / 2 - 50);
    pg.text("B", pg.width * 5 / 7, pg.height / 2 - 50);

    pg.popMatrix();
    pg.popStyle();
    pg.endDraw();

    if (showHashCode) {
      String hash = String.format("%08x", String.format("%s-%02d%02d-meaningless-string", title, mode, value).hashCode());
      pg.textSize(12);
      pg.noStroke();
      pg.fill(0);
      pg.textAlign(LEFT, TOP);
      pg.text(hash, 0, 0);
    }
  }

  void drawParameters() {
    textAlign(LEFT, TOP);
    fill(0);
    stroke(0);
    text("radius A: " + radiusA + " px", 0, 0);
    text("radius B: " + radiusB + " px", 0, 20);
  }

  void recordCurrentValues(Experiment experiment) {
    experiment.appendResult(mode + 1, radiusA, radiusB);
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
