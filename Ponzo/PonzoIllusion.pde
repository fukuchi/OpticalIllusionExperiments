class PonzoIllusion {
  final int maxValue = 10;
  int value;
  final int radiusA = 80;
  int radiusB;
  final int AX = 240;
  final int BX = 400;
  final float angle = 0.5;
  int mode = 0;

  PonzoIllusion() {
    setValue(floor(random(-maxValue, maxValue)));
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

    pg.ellipse(cos(angle / 2) * AX, sin(angle / 2) * AX, radiusA, radiusA);
    pg.fill(0);
    pg.noStroke();
    pg.text("A", cos(angle / 2) * AX, -20);

    pg.stroke(0);
    pg.noFill();
    pg.ellipse(cos(angle / 2) * BX, sin(angle / 2) * BX, radiusB, radiusB);
    pg.fill(0);
    pg.noStroke();
    pg.text("B", cos(angle / 2) * BX, -20);

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
