class JastrowIllusion {
  final int maxValue = 10;
  int value;
  final int arcRadius = 350;
  final int barWidth = 120;
  final float startAngle = 240;
  final float endAngleA = 290;
  float endAngleB;
  final int lengthA = 350;
  int lengthB;
  final float shiftAngle = -5;
  final float shiftX = 50;
  int mode = 0;

  JastrowIllusion() {
    setValue(floor(random(-maxValue, maxValue)));
  }

  int getValue() {
    return value;
  }

  void setValue(int v) {
    if (v < -maxValue || v > maxValue) return;
    value = v;
    endAngleB = endAngleA + v;
    lengthB = lengthA + v * 5;
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
    if (mode == 0) {
      drawArcs(pg);
    } else {
      drawBars(pg);
    }
  }

  void drawArcs(PGraphics pg) {
    int x1, y1, x2, y2;

    pg.beginDraw();
    pg.background(255);
    pg.pushStyle();
    pg.strokeWeight(2);
    pg.textAlign(CENTER, CENTER);
    pg.textSize(16);
    pg.smooth();

    pg.pushMatrix();
    pg.translate(30, pg.height - sin(radians(startAngle)) * arcRadius - 30);
    pg.stroke(0);
    pg.noFill();
    pg.arc(pg.width / 2, 0, arcRadius * 2, arcRadius * 2, radians(startAngle), radians(endAngleA));
    pg.arc(pg.width / 2, 0, (arcRadius + barWidth) * 2, (arcRadius + barWidth) * 2, radians(startAngle), radians(endAngleA));
    x1 = round(cos(radians(endAngleA)) * arcRadius);
    y1 = round(sin(radians(endAngleA)) * arcRadius);
    x2 = round(cos(radians(endAngleA)) * (arcRadius + barWidth));
    y2 = round(sin(radians(endAngleA)) * (arcRadius + barWidth));
    pg.line(pg.width / 2 + x1, y1, pg.width / 2 + x2, y2);
    x1 = round(cos(radians(startAngle)) * arcRadius);
    y1 = round(sin(radians(startAngle)) * arcRadius);
    x2 = round(cos(radians(startAngle)) * (arcRadius + barWidth));
    y2 = round(sin(radians(startAngle)) * (arcRadius + barWidth));
    pg.line(pg.width / 2 + x1, y1, pg.width / 2 + x2, y2);
    pg.noStroke();
    pg.fill(0);
    pg.text("A", 50, (y1 + y2) / 2);

    pg.translate(0, -barWidth - 50);
    pg.stroke(0);
    pg.noFill();
    pg.arc(pg.width / 2, 0, arcRadius * 2, arcRadius * 2, radians(startAngle + shiftAngle), radians(endAngleB + shiftAngle));
    pg.arc(pg.width / 2, 0, (arcRadius + barWidth) * 2, (arcRadius + barWidth) * 2, radians(startAngle + shiftAngle), radians(endAngleB + shiftAngle));
    x1 = round(cos(radians(endAngleB + shiftAngle)) * arcRadius);
    y1 = round(sin(radians(endAngleB + shiftAngle)) * arcRadius);
    x2 = round(cos(radians(endAngleB + shiftAngle)) * (arcRadius + barWidth));
    y2 = round(sin(radians(endAngleB + shiftAngle)) * (arcRadius + barWidth));
    pg.line(pg.width / 2 + x1, y1, pg.width / 2 + x2, y2);
    x1 = round(cos(radians(startAngle + shiftAngle)) * arcRadius);
    y1 = round(sin(radians(startAngle + shiftAngle)) * arcRadius);
    x2 = round(cos(radians(startAngle + shiftAngle)) * (arcRadius + barWidth));
    y2 = round(sin(radians(startAngle + shiftAngle)) * (arcRadius + barWidth));
    pg.line(pg.width / 2 + x1, y1, pg.width / 2 + x2, y2);
    pg.noStroke();
    pg.fill(0);
    pg.text("B", 20, (y1 + y2) / 2);

    pg.popMatrix();
    pg.popStyle();
    pg.endDraw();
  }

  void drawBars(PGraphics pg) {
    pg.beginDraw();
    pg.background(255);
    pg.pushStyle();
    pg.strokeWeight(2);
    pg.textAlign(CENTER, CENTER);
    pg.textSize(16);
    pg.smooth();

    pg.pushMatrix();
    pg.translate(30, pg.height - 30);
    pg.stroke(0);
    pg.noFill();
    pg.rect(30, -barWidth, lengthA, barWidth);
    pg.noStroke();
    pg.fill(0);
    pg.text("A", 0, -barWidth / 2);
    pg.popMatrix();

    pg.pushMatrix();
    pg.translate(30, 30);
    pg.stroke(0);
    pg.noFill();
    pg.rect(30 + shiftX, 0, lengthB, barWidth);
    pg.noStroke();
    pg.fill(0);
    pg.text("B", shiftX, barWidth / 2);
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
