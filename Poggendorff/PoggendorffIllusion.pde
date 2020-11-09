class PoggendorffIllusion {
  final int maxValue = 10;
  int value;
  int lineProjectedLength;
  int endPointX;
  final int barWidth = 100;
  final int barHeight = 340;
  int mode = 0;

  PoggendorffIllusion() {
    setValue(floor(random(-maxValue, maxValue)));
    setMode(0);
  }

  int getValue() {
    return value;
  }

  void setValue(int v) {
    if (v < -maxValue || v > maxValue) return;
    value = v;
    endPointX = v * 3;
  }

  int getMaxValue() {
    return maxValue;
  }

  void setMode(int mode) {
    if (mode >= 0 && mode < 2) {
      this.mode = mode;
      lineProjectedLength = 120 + mode * 60;
    }
  }

  int getMode() {
    return mode;
  }

  void draw(PGraphics pg) {
    pg.beginDraw();
    pg.background(255);
    pg.pushMatrix();
    pg.translate(pg.width / 2, (pg.height - barHeight) / 2);
    pg.pushStyle();
    pg.stroke(0);
    pg.strokeWeight(2);
    pg.line(0, barHeight / 2, -lineProjectedLength, 0);
    pg.line(endPointX, barHeight / 2, lineProjectedLength + endPointX, barHeight);
    pg.strokeWeight(1);
    pg.fill(255);
    pg.rect(-barWidth / 2, 0, barWidth, barHeight);
    pg.popMatrix();
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
