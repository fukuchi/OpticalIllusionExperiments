class TriangleBisectionIllusion implements Illusion {
  final int maxValue = 25;
  final int minValue = -15;
  int value;
  int shift = 0;
  final int stimulusNum = 7;
  final int triangleHeight = 250;
  final int dividerWidth = 20;
  final int trapeziaHWidth = 50;
  int mode;

  TriangleBisectionIllusion() {
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
    shift = value * 4;
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
    float halfW = triangleHeight / sin(PI / 3) * 0.5;
    int summitY = (pg.height - triangleHeight) / 2;

    pg.beginDraw();
    pg.background(255);

    pg.pushMatrix();
    pg.pushStyle();
    pg.textAlign(CENTER, CENTER);
    pg.textSize(16);
    pg.smooth();

    pg.stroke(0);
    pg.strokeWeight(1);
    pg.noFill();

    pg.strokeWeight(2);

    pg.translate(pg.width / 2, summitY);
    if (mode == 0) {
      pg.triangle(0, 0, -halfW, triangleHeight, halfW, triangleHeight);
    } else {
      pg.quad(-trapeziaHWidth, 0, -halfW - trapeziaHWidth, triangleHeight, halfW + trapeziaHWidth, triangleHeight, trapeziaHWidth, 0);
    }


    pg.line(-dividerWidth / 2, triangleHeight / 2 + shift, dividerWidth / 2, triangleHeight / 2 + shift);

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
