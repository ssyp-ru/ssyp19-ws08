class NovelResource {
  public static final int T_BACKGROUND = 0, T_SPRITE = 1, T_SOUND = 2;
  String id;
  String ext, base64;
  int type;
  
  public NovelResource(String id, int type, String data) { // Load resource from file or base64
    this.id = id;
    this.ext = getExt(data);
    this.type = type;
    importFile(data);
  }
  public NovelResource(String id, int type, String data, String ext) { // Load resource from file or base64
    this.id = id;
    this.ext = ext;
    this.type = type;
    base64 = data;
  }
  public void exportFile(String path) { // Export base64 to file
    try {
      File file = new File(path);
      byte[] bytes = Base64.decode(base64.toCharArray());
      Files.write(file.toPath(), bytes);
    } catch(Exception e) {
      println("Error");
    }
  }
  public void importFile(String path) { // Import base64 from file
    try {
      File file = new File(path);
      byte[] bytes = Files.readAllBytes(file.toPath());
      base64 = Base64.encodeToString(bytes, false);
    } catch(Exception e) {
      println("Error");
    }
  }
  public String getExt(String path) {
    return path.split(".")[1];
  }
  public String exportToTemp() {
    String path = Config.TEMP_DIR + "/" + id + "." + ext;
    exportFile(path);
    return path;
  }
}
