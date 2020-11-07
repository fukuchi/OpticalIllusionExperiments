MullerLyerIllusion illusion;
final String title="Muller-Lyer";

void setup() {
  size(590, 400);
  surface.setTitle(title);

  illusion = new MullerLyerIllusion();
}

void draw() {
  illusion.draw();
  noLoop();
}

void keyPressed() {
  if (key == '1') {
    illusion.setMode(0);
  } else if (key == '2') {
    illusion.setMode(1);
  } else if (key == 's') {
    String filename = String.format("%s-%d.%02d.png", title, illusion.getMode(), illusion.getValue(), illusion.getMaxValue());
    save(filename);
  } else {
    illusion.keyPressed();
  }
  loop();
}
