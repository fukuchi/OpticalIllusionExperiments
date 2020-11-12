interface Illusion {
  void setMode(int mode);
  int getMode();
  void draw(PGraphics canvas);
  void recordCurrentValues(Experiment experiment);
}
