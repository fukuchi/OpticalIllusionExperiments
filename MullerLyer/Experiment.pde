class Experiment {
  Table results;
  int subjectsNum;

  Experiment() {
    results = new Table();
    results.addColumn("Number");
    results.addColumn("Mode");
    results.addColumn("Length A");
    results.addColumn("Length B");

    subjectsNum = 1;
  }

  void appendResult(int mode, int valueA, int valueB) {
    TableRow row = results.addRow();
    row.setInt("Number", subjectsNum);
    row.setInt("Mode", mode);
    row.setInt("Length A", valueA);
    row.setInt("Length B", valueB);

    subjectsNum++;
  }

  int currentSubjectNumber() {
    return subjectsNum;
  }

  void saveAsCSV(String filename) {
    saveTable(results, filename);
  }
}
