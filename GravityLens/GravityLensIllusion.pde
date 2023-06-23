class GravityLensIllusion implements Illusion {
  final int maxValue = 15;
  final int minValue = -20;
  int value;
  int shift = 0;
  final int stimulusNum = 7;
  final int dotRadius = 20;
  final int stimuliRadius = 150;
  final int stimuliShift = 92;
  int mode;

  GravityLensIllusion() {
    setMode(0);
    randomize();
  }

  void randomize() {
    setValue(floor(random(minValue, maxValue)));
  }

  int getValue() {
    return value;
  }

  void setValue(int v) {
    if (v < minValue || v > maxValue) return;
    value = v;
    shift = value;
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

    pg.stroke(0);
    pg.strokeWeight(1);
    pg.noFill();
    pg.rect(0, 0, pg.width - 1, pg.height - 1);

    pg.strokeWeight(2);
    pg.fill(0);
    pg.noStroke();

    pg.pushMatrix();
    pg.translate(pg.width * 0.35, pg.height / 2 - shift);
    pg.ellipse(0, 0, dotRadius, dotRadius);
    if (mode == 0) {
      pg.ellipse(0, stimuliShift, stimuliRadius, stimuliRadius);
    }
    pg.popMatrix();

    pg.pushMatrix();
    pg.translate(pg.width * 0.65, pg.height / 2 + shift);
    pg.ellipse(0, 0, dotRadius, dotRadius);
    if (mode == 0) {
      pg.ellipse(0, -stimuliShift, stimuliRadius, stimuliRadius);
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
    text("Shift length: " + shift * 2 + " px", 0, 0);
  }

  void recordCurrentValues(Experiment experiment) {
    experiment.appendResult(mode + 1, 0, shift * 2);
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
