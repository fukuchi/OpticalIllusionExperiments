boolean experimentMode = false;
boolean showHashCode = false;
boolean showParameters = true;

GravityLensIllusion illusion;
final String title="GravityLens";
PGraphics canvas;
Experiment experiment;

void settings() {
  if (experimentMode) {
    fullScreen();
  } else {
    size(1024, 768);
  }
}

void setup() {
  background(255);
  canvas = createGraphics(590, 400);
  surface.setTitle(title);

  illusion = new GravityLensIllusion();
  experiment = new Experiment(title);
  experiment.setIllusion(illusion);
}

void draw() {
  if (showParameters || experimentMode) {
    background(255);
  }
  if (showParameters) {
    illusion.drawParameters();
  }
  if (experimentMode) {
    fill(0);
    noStroke();
    textAlign(CENTER, TOP);
    text("Subject No. " + experiment.currentSubjectNumber(), width / 2, 0);
    text("Mode: " + (illusion.getMode() + 1), width / 2, 20);
    experiment.draw(canvas);
  } else {
    illusion.draw(canvas);
  }
  image(canvas, (width - canvas.width) / 2, (height - canvas.height) / 2);
  noLoop();
}

void keyPressed() {
  if (key == '1' && !experimentMode) {
    illusion.setMode(0);
  } else if (key == '2' && !experimentMode) {
    illusion.setMode(1);
  } else if (key == 's') {
    String filename = String.format("%s-%d.%02d.png", title, illusion.getMode() + 1, illusion.getValue(), illusion.getMaxValue());
    canvas.save(filename);
  } else if (key == ' ' && experimentMode) {
    experiment.nextPhase();
  } else {
    illusion.keyPressed();
  }
  loop();
}
