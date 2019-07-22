class Bttn{      //Button class
  float sizeX;
  float sizeY;
    float bttnX;
    float bttnY;
    float angle;
    boolean enable = false;
    Bttn(float a, float b, float c, float d, float e){      //Object parameters
      sizeX = c; 
      sizeY = d;
      bttnX = a; 
      bttnY = b;
    angle = e;
  }
  
  void update() {      //Drawing button
    if (enable){
      strokeWeight(3);
      stroke(RedStr, GreenStr, BlueStr);
      fill(Red, Green, Blue);
      rect(bttnX, bttnY, sizeX, sizeY, angle);
    }
  }
  
  boolean clickCheck() {  //Проверка нажатия
    if (enable)
      if (mousePressed == true) {
        if (aimCheck()){
          return true;
        }
      }
    return false;
  }
  
  boolean aimCheck(){  //Проверка наводки на кнопку
    if (enable)
      if (mouseX >= bttnX && mouseY >= bttnY && mouseX <= bttnX + sizeX && mouseY <= bttnY + sizeY) {
        return true;
      }
    return false;
  }
}
