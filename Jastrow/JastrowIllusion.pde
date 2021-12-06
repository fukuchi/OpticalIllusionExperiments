class JastrowIllusion implements Illusion {
  final int maxValue = 10;
  int value;
  final int arcRadius = 350;
  final int barWidth = 120;
  final int startAngle = 240;
  final int endAngleA = 290;
  int endAngleB;
  int lengthA, lengthB;
  final float shiftAngle = -5;
  final float shiftX = 50;
  int mode;

  JastrowIllusion() {
    setMode(0);
    randomize();
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
    endAngleB = endAngleA + v;
    lengthA = round((arcRadius + barWidth / 2) * radians(endAngleA - startAngle));
    lengthB = round((arcRadius + barWidth / 2) * radians(endAngleB - startAngle));
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
    if (mode == 0) {
      drawArcs(pg);
    } else {
      drawBars(pg);
    }
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

  void drawArcs(PGraphics pg) {
    int x1, y1, x2, y2;

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
  }

  void drawBars(PGraphics pg) {


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
  }

  void drawParameters() {
    textAlign(LEFT, TOP);
    fill(0);
    stroke(0);
    text(String.format("Angle A: %2d deg (%3d px)", endAngleA - startAngle, lengthA), 0, 0);
    text(String.format("Angle B: %2d deg (%3d px)", endAngleB - startAngle, lengthB), 0, 20);
  }

  void recordCurrentValues(Experiment experiment) {
    experiment.appendResult(mode + 1, endAngleA, endAngleB);
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
