interface Illusion {
  void setMode(int mode);
  void randomize();
  int getMode();
  void draw(PGraphics canvas);
  void recordCurrentValues(Experiment experiment);
}
