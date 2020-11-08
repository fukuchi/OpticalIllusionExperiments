class DelboeufIllusion {
  final int maxValue = 10;
  int value;
  final int radiusA = 60;
  int radiusB;
  final int outerRadiusL = 120;
  final int outerRadiusS = 70;
  int mode = 0;

  DelboeufIllusion() {
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
