class FickIllusion implements Illusion {
  final int maxValue = 10;
  int value;
  final int barThickness = 40;
  final int barLengthA = 250;
  int barLengthB;
  int mode = 0;

  FickIllusion() {
    setValue(floor(random(-maxValue, maxValue)));
  }

  int getValue() {
    return value;
  }

  void setValue(int v) {
    if (v < -maxValue || v > maxValue) return;
    value = v;
    barLengthB = barLengthA + v * 5;
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
    pg.translate(0, 50);

    pg.pushStyle();
    pg.textAlign(CENTER, CENTER);
    pg.textSize(16);

    pg.fill(255);
    pg.stroke(0);
    pg.rect((pg.width - barLengthA) / 2, 0, barLengthA, barThickness);
    pg.fill(0);
    pg.noStroke();
    pg.text("A", (pg.width - barLengthA) / 2 + 10, barThickness / 2);

    pg.fill(255);
    pg.stroke(0);
    if (mode > 0) {
      pg.translate((pg.width + barLengthA) / 2 + barThickness / 2, barThickness);
    } else {
      pg.translate(pg.width / 2, barThickness);
    }
    pg.rect(-barThickness / 2, 0, barThickness, barLengthB);
    pg.fill(0);
    pg.noStroke();
    pg.text("B", 0, 20);
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
    text("Height A: " + barLengthA + " px", 0, 0);
    text("Height B: " + barLengthB + " px", 0, 20);
  }

  void recordCurrentValues(Experiment experiment) {
    experiment.appendResult(mode + 1, barLengthA, barLengthB);
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
