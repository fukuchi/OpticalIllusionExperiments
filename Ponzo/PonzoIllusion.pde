class PonzoIllusion implements Illusion {
  final int maxValue = 15;
  int value;
  final int radiusA = 40;
  int radiusB;
  final int AX = 240;
  final int BX = 400;
  final float angle = radians(30);
  int mode;

  PonzoIllusion() {
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
    radiusB = radiusA + v;
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
    pg.translate(10, 50);
    pg.pushStyle();
    pg.textAlign(CENTER, CENTER);
    pg.textSize(16);
    pg.stroke(0);
    pg.noFill();
    pg.smooth();

    pg.strokeWeight(2);
    pg.line(0, 0, pg.width, 0);
    if (mode > 0) {
      pg.line(0, 200, pg.width, 200);
    } else {
      pg.line(0, 0, cos(angle) * pg.width, sin(angle) * pg.width);
    }

    pg.ellipse(cos(angle / 2) * AX, sin(angle / 2) * AX, radiusA * 2, radiusA * 2);
    pg.fill(0);
    pg.noStroke();
    pg.text("A", cos(angle / 2) * AX, -20);

    pg.stroke(0);
    pg.noFill();
    pg.ellipse(cos(angle / 2) * BX, sin(angle / 2) * BX, radiusB * 2, radiusB * 2);
    pg.fill(0);
    pg.noStroke();
    pg.text("B", cos(angle / 2) * BX, -20);

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
    text("Radius A: " + radiusA + " px", 0, 0);
    text("Radius B: " + radiusB + " px", 0, 20);
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
