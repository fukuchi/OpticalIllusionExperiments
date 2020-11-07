class EbbinghausIllusion {
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
  int mode = 0;

  EbbinghausIllusion() {
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

  void draw() {
    background(255);
    pushStyle();
    textAlign(CENTER, CENTER);
    textSize(16);
    noStroke();
    fill(0);
    smooth();

    pushMatrix();
    translate(width / 3, height / 2); 
    ellipse(0, 0, centerRadiusA, centerRadiusA);
    for (int i=0; i<8; i++) {
      float x = cos(TWO_PI * i / 8 + 0.2) * stimuliDistanceL;
      float y = sin(TWO_PI * i / 8 + 0.2) * stimuliDistanceL;
      if (mode == 0) {
        ellipse(x, y, stimuliRadiusL, stimuliRadiusL);
      } else {
        rect(x - stimuliWidthL / 2, y - stimuliWidthL / 2, stimuliWidthL, stimuliWidthL);
      }
    }
    text("A", 0, height / 2 - 20);
    popMatrix();

    pushMatrix();
    translate(width * 4 / 5, height / 2); 
    ellipse(0, 0, centerRadiusB, centerRadiusB);
    for (int i=0; i<8; i++) {
      float x = cos(TWO_PI * i / 8 + 0.2) * stimuliDistanceS;
      float y = sin(TWO_PI * i / 8 + 0.2) * stimuliDistanceS;
      if (mode == 0) {
        ellipse(x, y, stimuliRadiusS, stimuliRadiusS);
      } else {
        rect(x - stimuliWidthS / 2, y - stimuliWidthS / 2, stimuliWidthS, stimuliWidthS);
      }
    }
    text("B", 0, height / 2 - 20);
    popMatrix();

    popStyle();
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
