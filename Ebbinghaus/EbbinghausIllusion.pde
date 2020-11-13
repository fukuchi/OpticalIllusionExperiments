class EbbinghausIllusion implements Illusion {
  final int maxValue = 10;
  int value;
  final int stimuliRadiusL = 80;
  final int stimuliRadiusS = 25;
  final int stimuliWidthL = round(stimuliRadiusL / 2 * 1.77);
  final int stimuliWidthS = round(stimuliRadiusS / 2 * 1.77);
  final int stimuliDistanceL = 120;
  final int stimuliDistanceS = 60;
  final int centerRadiusA = 60;
  int centerRadiusB;
  int mode;

  EbbinghausIllusion() {
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
    centerRadiusB = centerRadiusA + v * 2;
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
    pg.noStroke();
    pg.fill(0);
    pg.smooth();

    pg.pushMatrix();
    pg.translate(pg.width / 3, pg.height / 2); 
    pg.ellipse(0, 0, centerRadiusA, centerRadiusA);
    for (int i=0; i<8; i++) {
      float x = cos(TWO_PI * i / 8 + 0.2) * stimuliDistanceL;
      float y = sin(TWO_PI * i / 8 + 0.2) * stimuliDistanceL;
      if (mode == 0) {
        pg.ellipse(x, y, stimuliRadiusL, stimuliRadiusL);
      } else {
        pg.rect(x - stimuliWidthL / 2, y - stimuliWidthL / 2, stimuliWidthL, stimuliWidthL);
      }
    }
    pg.text("A", 0, pg.height / 2 - 20);
    pg.popMatrix();

    pg.pushMatrix();
    pg.translate(pg.width * 4 / 5, pg.height / 2); 
    pg.ellipse(0, 0, centerRadiusB, centerRadiusB);
    for (int i=0; i<8; i++) {
      float x = cos(TWO_PI * i / 8 + 0.2) * stimuliDistanceS;
      float y = sin(TWO_PI * i / 8 + 0.2) * stimuliDistanceS;
      if (mode == 0) {
        pg.ellipse(x, y, stimuliRadiusS, stimuliRadiusS);
      } else {
        pg.rect(x - stimuliWidthS / 2, y - stimuliWidthS / 2, stimuliWidthS, stimuliWidthS);
      }
    }
    pg.text("B", 0, pg.height / 2 - 20);
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
    text("Radius A: " + centerRadiusA + " px", 0, 0);
    text("Radius B: " + centerRadiusB + " px", 0, 20);
  }

  void recordCurrentValues(Experiment experiment) {
    experiment.appendResult(mode + 1, centerRadiusA, centerRadiusB);
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
