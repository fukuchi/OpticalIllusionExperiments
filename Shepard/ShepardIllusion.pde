class ShepardIllusion implements Illusion {
  final int maxValue = 10;
  int value;
  final int tableWA = 100;
  int tableWB;
  final int tableD = 180;
  final int tableH = 40;
  final int slant = -30;
  final int tableBRotationAngle = 80;
  PVector[] tableA, tableB;
  int mode;

  ShepardIllusion() {
    tableA = new PVector[4];
    tableB = new PVector[4];

    tableA[0] = new PVector(-tableWA / 2 - slant / 2, -tableD / 2);
    tableA[1] = new PVector( tableWA / 2 - slant / 2, -tableD / 2);
    tableA[2] = new PVector( tableWA / 2 + slant / 2, tableD / 2);
    tableA[3] = new PVector(-tableWA / 2 + slant / 2, tableD / 2);

    setMode(0);
    randomize();
  }

  void randomize() {
    setValue(floor(random(-maxValue / 2, maxValue / 2)));
  }

  int getValue() {
    return value;
  }

  void setValue(int v) {
    if (v < -maxValue || v > maxValue) return;
    value = v;
    tableWB = tableWA + v * 4;
    setPoints();
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

  void setPoints() {
    float rad = radians(tableBRotationAngle);
    tableB[0] = new PVector(-tableWB / 2 - slant / 2, -tableD / 2).rotate(rad);
    tableB[1] = new PVector( tableWB / 2 - slant / 2, -tableD / 2).rotate(rad);
    tableB[2] = new PVector( tableWB / 2 + slant / 2, tableD / 2).rotate(rad);
    tableB[3] = new PVector(-tableWB / 2 + slant / 2, tableD / 2).rotate(rad);
  }

  void draw(PGraphics pg) {
    pg.beginDraw();
    pg.background(255);
    pg.pushStyle();
    pg.textAlign(CENTER, CENTER);
    pg.textSize(16);
    pg.smooth();
    pg.strokeWeight(2);

    pg.pushMatrix();
    pg.translate(pg.width * 2 / 7, pg.height / 2);
    pg.stroke(0);
    pg.fill(128);
    pg.beginShape(QUADS);
    pg.vertex(tableA[0].x, tableA[0].y);
    pg.vertex(tableA[1].x, tableA[1].y);
    pg.vertex(tableA[2].x, tableA[2].y);
    pg.vertex(tableA[3].x, tableA[3].y);
    pg.endShape();
    pg.noFill();
    if (mode == 0) {
      pg.beginShape();
      pg.vertex(tableA[1].x, tableA[1].y);
      pg.vertex(tableA[1].x, tableA[1].y + tableH);
      pg.vertex(tableA[2].x, tableA[2].y + tableH);
      pg.vertex(tableA[3].x, tableA[3].y + tableH);
      pg.vertex(tableA[3].x, tableA[3].y);
      pg.endShape();
      pg.line(tableA[2].x, tableA[2].y, tableA[2].x, tableA[2].y + tableH);
    }
    pg.fill(0);
    pg.noStroke();
    pg.text("A", 0, pg.height / 2 - 30);
    pg.popMatrix();

    pg.pushMatrix();
    pg.translate(pg.width * 5 / 7, pg.height / 2);
    pg.stroke(0);
    pg.fill(128);
    pg.beginShape(QUADS);
    pg.vertex(tableB[0].x, tableB[0].y);
    pg.vertex(tableB[1].x, tableB[1].y);
    pg.vertex(tableB[2].x, tableB[2].y);
    pg.vertex(tableB[3].x, tableB[3].y);
    pg.endShape();
    pg.noFill();
    if (mode == 0) {
      pg.beginShape();
      pg.vertex(tableB[1].x, tableB[1].y);
      pg.vertex(tableB[1].x, tableB[1].y + tableH);
      pg.vertex(tableB[2].x, tableB[2].y + tableH);
      pg.vertex(tableB[3].x, tableB[3].y + tableH);
      pg.vertex(tableB[3].x, tableB[3].y);
      pg.endShape();
      pg.line(tableB[2].x, tableB[2].y, tableB[2].x, tableB[2].y + tableH);
    }
    pg.fill(0);
    pg.noStroke();
    pg.text("B", 0, pg.height / 2 - 30);
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
    text("Width A: " + tableWA + " px", 0, 0);
    text("Width B: " + tableWB + " px", 0, 20);
  }

  void recordCurrentValues(Experiment experiment) {
    experiment.appendResult(mode + 1, tableWA, tableWB);
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
