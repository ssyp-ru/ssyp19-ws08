class EditText {
  int x, y, w, size;
  String text = "";
  boolean enable = true, focus = false;
  
  public EditText(int x, int y, int w, int size) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.size = size;
  }
  
  public void keyPress() { // Check key pressed
    if(!enable) return;
    if(Character.toString(key).matches("[0-9a-zA-Zа-яА-Я!@#$%^&*\\(\\)-=_+:;'\" ]")) text += key;
    else if(key == BACKSPACE && text.length() > 0) text = text.substring(0, text.length() - 1);
  }
  
  public void render() {
    if(!enable) return;
    fill(Config.CONF_FIELD_BG);
    stroke(Config.CONF_FIELD_STROKE);
    rect(x, y, w, size);
    
    text(wrap(), x, y);
  }
  
  public String wrap() { // Wrap text length
    text = text.replaceAll("\n", "");
    String data = "";
    for(int i = text.length() - 1; i >= 0; i--)
      if(textWidth(text.charAt(i) + data) > w) break;
      else data = text.charAt(i) + data;
    return data;
  }
}
