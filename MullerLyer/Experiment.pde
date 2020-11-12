class Experiment {
  Table results;
  int subjectsNum;
  String filename;
  Illusion illusion;
  int phase;

  Experiment(String title) {
    results = new Table();
    results.addColumn("Number");
    results.addColumn("Mode");
    results.addColumn("A");
    results.addColumn("B");

    filename = String.format("%s-results-%04d%02d%02d-%02d%02d%02d.csv", 
      title, year(), month(), day(), hour(), minute(), second());

    subjectsNum = 1;
    phase = 0;
  }

  void setIllusion(Illusion illusion) {
    this.illusion = illusion;
  }

  void nextPhase() {
    phase++;
    if (phase >= 5) phase = 0;
    if (phase == 1) {
      illusion.setMode(0);
    } else if (phase == 2) {
      illusion.recordCurrentValues(experiment);
    } else if (phase == 3) {
      illusion.setMode(1);
    } else if (phase == 4) {
      illusion.recordCurrentValues(experiment);
      incrementSubjectNumber();
      saveAsCSV();
    }
  }

  void draw(PGraphics canvas) {
    if (phase == 0) {
      drawSignboard(canvas, "START");
    } else if (phase == 1 || phase == 3) {
      illusion.draw(canvas);
    } else if (phase == 2) {
      drawSignboard(canvas, "NEXT FIGURE");
    } else if (phase == 4) {
      drawSignboard(canvas, "FINISHED");
    }
  }

  void drawSignboard(PGraphics canvas, String text) {
    canvas.beginDraw();
    canvas.background(192);
    canvas.pushStyle();
    canvas.pushMatrix();
    canvas.textSize(16);
    canvas.fill(0);
    canvas.noStroke();
    canvas.textAlign(CENTER, CENTER);
    canvas.translate(canvas.width / 2, canvas.height / 2);
    canvas.text(text, 0, 0);
    canvas.stroke(0);
    canvas.noFill();
    canvas.rect(-100, -50, 200, 100);
    canvas.popStyle();
    canvas.popMatrix();
    canvas.endDraw();
  }

  void appendResult(int mode, int valueA, int valueB) {
    TableRow row = results.addRow();
    row.setInt("Number", subjectsNum);
    row.setInt("Mode", mode);
    row.setInt("A", valueA);
    row.setInt("B", valueB);
  }

  void incrementSubjectNumber() {
    subjectsNum++;
  }

  int currentSubjectNumber() {
    return subjectsNum;
  }

  void saveAsCSV() {
    saveTable(results, filename);
  }
}
