class ZollnerIllusion {
  final int maxValue = 10;
  int value;
  final int slantA = 200;
  int slantB;
  final int lineInterval = 200;
  final int wingLength = 25;
  int mode = 0;

  ZollnerIllusion() {
    setValue(floor(random(-maxValue, maxValue)));
  }

  int getValue() {
    return value;
  }

  void setValue(int v) {
    if (v < -maxValue || v > maxValue) return;
    value = v;
    slantB = slantA + v * 2;
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
    pg.translate(-30, 25);

    pg.pushStyle();
    pg.textAlign(CENTER, CENTER);
    pg.textSize(16);
    pg.stroke(0);
    pg.strokeWeight(8);
    pg.fill(0);
    pg.smooth();

    for (int i=0; i<4; i++) {
      pg.line(i * lineInterval - slantB, 0, i * lineInterval + slantB, pg.height - 50);
      if (mode == 0) {
        for (int y = 10; y < pg.height - 50; y += 30) {
          int x = i * lineInterval - slantB + (slantB * 2) * y / (pg.height - 50);
          int d = round(random(-5, 5));
          pg.line(x - wingLength + d, y, x + wingLength + d, y);
        }
      }
    }

    pg.translate(lineInterval / 2, 0);
    for (int i=0; i<4; i++) {
      pg.line(i * lineInterval - slantA, 0, i * lineInterval + slantA, pg.height - 50);
      if (mode == 0) {
        for (int y = 10; y < pg.height - 50; y += 30) {
          int x = i * lineInterval - slantA + (slantA * 2) * y / (pg.height - 50);
          int d = round(random(-5, 5));
          pg.line(x, y - wingLength + d, x, y + wingLength + d);
        }
      }
    }
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
