class Input {
  boolean ctrl = false;
  boolean show = false;
  int x, y, w, size;
  int margin = 20, textmargin = 5;
  String title, text = "", regex = ".*";
  int failed = Integer.MIN_VALUE;
  InputCallback callback;
  
  public Input(String title, int x, int y, int w) { // Create new instance of input using coordinates and width 
    this.title = title;
    this.x = x;
    this.y = y;
    this.w = w;
    this.size = w / 11;
  }
  public void keyPress() { // Check key pressed
    if(keyCode == CONTROL) ctrl = true;
    if(ctrl && keyCode == 86) paste();
    else if(Character.toString(key).matches("[0-9a-zA-Zа-яА-Я!@#$%^&*\\(\\)-=_+:;'\" ]")) text += key;
    else if(key == BACKSPACE && text.length() > 0) text = text.substring(0, text.length() - 1);
    else if(key == ENTER) validate();
  }
  public void keyRelease() { // Check CTRL release
    if(keyCode == CONTROL) ctrl = false;
  }
  public void render() { // Render all dis stuff
    if(!show) return;
    fill(255);
    noStroke();
    rect(x, y, w, margin + size + margin + textmargin + size + textmargin + margin);
    
    fill(200);
    if(failed + 3000 > millis()) stroke(255, 0, 0);
    else noStroke();
    rect(x + margin, y + margin + size + margin, w - margin * 2, size + textmargin * 2);
    
    fill(0);
    textSize(size);
    text(title, x + w / 2 - textWidth(title) / 2, y + margin + size);
    String wrapped = wrap();
    text(wrapped, x + margin + textmargin, y + margin + size + margin + textmargin + size);
    stroke(millis() % 1000 > 500 ? 0 : 200);
    line(x + margin + textWidth(wrapped + " "), y + margin + size + margin + textmargin, x + margin + textWidth(wrapped + " "), y + margin + size + margin + textmargin + size);
  }
  public String wrap() { // Wrap text length
    text = text.replaceAll("\n", "");
    String data = "";
    for(int i = text.length() - 1; i >= 0; i--)
      if(textWidth(text.charAt(i) + data) > w - margin * 2 - textmargin / 2) break;
      else data = text.charAt(i) + data;
    return data;
  }
  
  public void setCallback(InputCallback callback) { // Set callback for ENTER press
    this.callback = callback;
  }
  public void setRegex(String regex) { // Set filter regex
    this.regex = regex;
  }
  public String getText() { // Get current text
    return text;
  }
  
  public void validate() { // Validate text using filter regex and execute callback
    if(text.matches(regex) && callback != null) callback.finish(text);
    else if(callback != null) {
      callback.fail(text);
      failed = millis();
    }
  }
  public void paste() { // Paste text from clipboard
    text += (String)getFromClipboard(DataFlavor.stringFlavor);
  }
  Object getFromClipboard (DataFlavor flavor) { // DONT TOUCH DIS THING IDK HOW IT WORKS
    Clipboard clipboard = Toolkit.getDefaultToolkit().getSystemClipboard(); 
    Transferable contents = clipboard.getContents(null);
    Object object = null;
    if(contents != null && contents.isDataFlavorSupported(flavor)) {
      try {
        object = contents.getTransferData(flavor);
        println("Clipboard.getFromClipboard() >> Object transferred from clipboard.");
      } catch (UnsupportedFlavorException e1) {
        println("Clipboard.getFromClipboard() >> Unsupported flavor: " + e1);
      } catch (java.io.IOException e2) {
        println("Clipboard.getFromClipboard() >> Unavailable data: " + e2);
      }
    }
    return object;
  }
  void cleare(){
    text = ""; 
  }
}
interface InputCallback {
  void finish(String text); // Enter pressed and text is valid
  void fail(String text); // Enter pressed but text is not valid
}
