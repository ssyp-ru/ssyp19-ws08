class Button {
  float sizeX, sizeY, bttnX, bttnY, corner;
  ButtonCallback callback;
  boolean clickState = false, hoverState = false, enable = false;
  
  public Button(float a, float b, float c, float d, float e) { // Create new instance of Button from x, y, w, h and corner
    bttnX = a; 
    bttnY = b;
    sizeX = c; 
    sizeY = d;
    corner = e;
  }
  public void setCallback(ButtonCallback callback) { // Set button callback
    this.callback = callback;
  }
  void render() { // Render button and check events
    if(enable) {
      if(clickState != clicked() && callback != null) {
        callback.clickChange(clicked());
        clickState = clicked();
      }
      if(hoverState != hovered() && callback != null) {
        callback.hoverChange(hovered());
        hoverState = hovered();
      }
      if(!hovered()) {
        fill(Config.BTN);
        stroke(Config.BTN_STROKE);
      } else {
        fill(Config.BTN);
        stroke(Config.BTN_STROKE);
      }
      rect(bttnX, bttnY, sizeX, sizeY, corner);
    }
  }
  boolean clicked() { // Check if button is clicked
     return enable && mousePressed && hovered();
  }
  boolean hovered() { // Check if button is hovered
    return enable && mouseX >= bttnX && mouseY >= bttnY && mouseX <= bttnX + sizeX && mouseY <= bttnY + sizeY;
  }
}
interface ButtonCallback {
  void clickChange(boolean clicked);
  void hoverChange(boolean hovered);
}
