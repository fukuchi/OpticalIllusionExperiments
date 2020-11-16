class PoggendorffIllusion implements Illusion {
  final int maxValue = 15;
  int value;
  int lineProjectedLength;
  int shiftY;
  final int barWidth = 100;
  final int barHeight = 340;
  final int[] angles = {30, 45};
  int angle;
  int mode;

  PoggendorffIllusion() {
    randomize();
    setMode(0);
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
    shiftY = v * 3;
  }

  int getMaxValue() {
    return maxValue;
  }

  void setMode(int mode) {
    if (mode >= 0 && mode < 2) {
      this.mode = mode;
      angle = angles[mode];
    }
  }

  int getMode() {
    return mode;
  }

  void draw(PGraphics pg) {
    float rad = radians(angle);
    float endPointX1 = -barHeight / 2 * tan(rad);
    float endPointX2 = (barHeight / 2 - shiftY) * tan(rad);
    pg.beginDraw();
    pg.background(255);
    pg.pushMatrix();
    pg.translate(pg.width / 2, (pg.height - barHeight) / 2);
    pg.pushStyle();
    pg.stroke(0);
    pg.strokeWeight(2);
    pg.line(0, barHeight / 2, endPointX1, 0);
    pg.line(0, barHeight / 2 + shiftY, endPointX2, barHeight);
    pg.strokeWeight(1);
    pg.fill(255);
    pg.rect(-barWidth / 2, 0, barWidth, barHeight);
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
