PonzoIllusion illusion;
final String title="Ponzo";
PGraphics canvas;

void setup() {
  fullScreen();
  //size(590, 400);
  background(255);
  canvas = createGraphics(590, 400);
  surface.setTitle(title);

  illusion = new PonzoIllusion();
}

void draw() {
  illusion.draw(canvas);
  image(canvas, (width - canvas.width) / 2, (height - canvas.height) / 2);
  noLoop();
}

void keyPressed() {
  if (key == '1') {
    illusion.setMode(0);
  } else if (key == '2') {
    illusion.setMode(1);
  } else if (key == 's') {
    String filename = String.format("%s-%d.%02d.png", title, illusion.getMode() + 1, illusion.getValue(), illusion.getMaxValue());
    canvas.save(filename);
  } else {
    illusion.keyPressed();
  }
  loop();
}
