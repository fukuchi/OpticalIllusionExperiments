class KanizsaIllusion {
  final int maxValue = 10;
  int value;
  final int squareWidthA = 150;
  int squareWidthB;
  final int occluderHeightMode1 = 200;
  final int occluderHeightMode2 = 100;
  int occluderWidth;
  int occluderHeight;
  int mode = 0;

  KanizsaIllusion() {
    setValue(floor(random(-maxValue, maxValue)));
    setMode(0);
  }

  int getValue() {
    return value;
  }

  void setValue(int v) {
    if (v < -maxValue || v > maxValue) return;
    value = v;
    squareWidthB = squareWidthA + v * 2;
  }

  int getMaxValue() {
    return maxValue;
  }

  void setMode(int mode) {
    if (mode >= 0 && mode < 2) {
      this.mode = mode;
      if (mode == 0) {
        occluderHeight = occluderHeightMode1;
      } else {
        occluderHeight = occluderHeightMode2;
      }
      occluderWidth = occluderHeight / 2;
    }
  }

  int getMode() {
    return mode;
  }

  void draw(PGraphics pg) {
    pg.beginDraw();
    pg.background(255);
    pg.pushStyle();
    pg.strokeWeight(2);
    pg.textAlign(CENTER, CENTER);
    pg.textSize(16);
    pg.pushMatrix();

    pg.translate(pg.width * 2 / 7, pg.height / 2);
    pg.stroke(0);
    pg.noFill();
    pg.rect(-squareWidthA / 2, -squareWidthA / 2, squareWidthA, squareWidthA);

    pg.translate(pg.width * 3 / 7, 0);
    pg.rect(-squareWidthB / 2, -squareWidthA / 2, squareWidthB, squareWidthA);
    pg.noStroke();
    pg.fill(0);
    pg.rect(-occluderWidth / 2, -occluderHeight / 2, occluderWidth, occluderHeight);

    pg.popMatrix();
    pg.text("A", pg.width * 2 / 7, pg.height - 50);
    pg.text("B", pg.width * 5 / 7, pg.height - 50);

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
