void drawNew() {      //Draw edit menu | Отрисовка меню
  background(bckg);
  
  
  //vn-part
  data.tick();
  data.render();
  
  addTextEl.render();
  //addChoiceEl.render();
  addBackgroundEl.render();
  addSpriteEl.render();
  //addSoundEl.render();
  btnPlay.render();
  
  image(imgNew, 220, 10, 64, 36);
  image(imgSprite, 220, 10 + 36 + 10 + 36 + 10);
  image(imgBackground, 220, 10 + 36 + 10);
  
  //EditPlayBack.drawBackGround();
  addSprite.enable = true;
  addBackground.enable = true;
  addCounter.enable = true;
  addSound.enable = true;

  spriteList.enable = true;
  backgroundList.enable = true;
  charList.enable = true;
  soundList.enable = true;
  

  //Проверка нажатия на добавление спрайта
  if (addSprite.clickCheck() || importSprite.aimCheck() && importSprite.enable) {      //Click check, if button pressed | Проверка нажатия на кнопку
    importSprite.enable = true;
    spriteAdded.enable = true;
    
    input.setRegex("[a-zA-Z0-9_\\-]+");
    input.setCallback(new InputCallback() {
      public void finish(String s) {
        input.show = false;
        println("finish: " + s);
      }
      public void fail(String s) {
        println("fail: " + s);
      }
    });
    input.show = true;
    
    if (spriteAdded.clickCheck()){
      importSprite.enable = false;
      spriteAdded.enable = false;
      sprts[cntS] = new Sprite(input.getText());
     cntS++;
      input.cleare();
      input.show = false;
    }

    stroke(RedStr, GreenStr, BlueStr);
    fill(Red, Green, Blue);
  } else {
    importSprite.enable = false;
    spriteAdded.enable = false;
  }
  
  //Проверка нажатия на добавление фона
  if (addBackground.clickCheck() || importBackground.aimCheck() && importBackground.enable) {      //Click check, if button pressed | Проверка нажатия на кнопку
    importBackground.enable = true;
    backgroundAdded.enable = true;
    
    
    input.setRegex("[a-zA-Z0-9_\\-]+");
    input.setCallback(new InputCallback() {
      public void finish(String s) {
        input.show = false;
        println("finish: " + s);
      }
      public void fail(String s) {
        println("fail: " + s);
      }
    }
    );
    input.show = true;

    if (backgroundAdded.clickCheck()){
      importBackground.enable = false;
      backgroundAdded.enable = false;
      bgs[cntBG] = new BackGround(input.getText());
      cntBG++;
      input.cleare();
      input.show = false;
    }
    
    stroke(RedStr, GreenStr, BlueStr);
    fill(Red, Green, Blue);
  } else {
    importBackground.enable = false;
    backgroundAdded.enable = false;
  }
  
  //Проверка нажатия на добавление текста
  //if (addCounter.clickCheck() || importCounter.aimCheck() && importCounter.enable) {      //Click check, if button pressed | Проверка нажатия на кнопку
  //  importCounter.enable = true;
  //  counterAdded.enable = true;
    
  //  if (counterAdded.clickCheck()){
  //    importCounter.enable = false;
  //    counterAdded.enable = false;
  //  }
    
  //  input.setRegex("[a-zA-Z0-9_\\-]+");
  //  input.setCallback(new InputCallback() {
  //    public void finish(String s) {
  //      input.show = false;
  //      println("finish: " + s);
  //    }
  //    public void fail(String s) {
  //      println("fail: " + s);
  //    }
  //  }
  //  );
  //  input.show = true;

  //  input.render();
  //  stroke(RedStr, GreenStr, BlueStr);
  //  fill(Red, Green, Blue);
  //} else {
  //  importCounter.enable = false;
  //  counterAdded.enable = false;
  //}
  
  //Проверка нажатия на добавление звука
  if (addSound.clickCheck() || importSound.aimCheck() && importSound.enable) {      //Click check, if button pressed | Проверка нажатия на кнопку
    importSound.enable = true;
    soundAdded.enable = true;
    
    
    input.setRegex("[a-zA-Z0-9_\\-]+");
    input.setCallback(new InputCallback() {
      public void finish(String s) {
        input.show = false;
        println("finish: " + s);
      }
      public void fail(String s) {
        println("fail: " + s);
      }
    }
    );
    input.show = true;

    if (soundAdded.clickCheck()){
      importSound.enable = false;
      soundAdded.enable = false;
      sngs[cntM] = new Music(input.getText());
      cntM++;
      input.cleare();
      input.show = false;
    }
    
    stroke(RedStr, GreenStr, BlueStr);
    fill(Red, Green, Blue);
  } else {
    importSound.enable = false;
    soundAdded.enable = false;
  }
  
  
  backgroundList.update();
  spriteList.update();
  charList.update();
  soundList.update();

  addSprite.update();
  addBackground.update();
  addCounter.update();
  addSound.update();
  image(imgSprite, 15, height / 40);
  image(imgBackground, 15, height / 1.9);
  image(imgSound, width / 1.166667 + 15, height /  1.9);

  fill(0);
  textSize(15);
  for (int i = 0; i < CONST; i++){
    if(bgs[i] != null) text(bgs[i].name, 15, height / 1.9 + 20 + 20 * i + height / 20);
    if(sprts[i] != null) text(sprts[i].name,15, height / 40 + 20 + 20 * i + height / 20);
    if(sngs[i] != null) text(sngs[i].name, width / 1.166667, height / 1.9 + 20 + 20 * i + height / 20);
    if(cntrs[i] != -1) text(i + 1, width / 1.166667, height / 40 + 20 + 20 * i + height / 20);
  }

  importSprite.update();
  importBackground.update();
  importCounter.update();
  importSound.update();
  
  spriteAdded.update();
  backgroundAdded.update();
  counterAdded.update();
  soundAdded.update();
  
  
  
  input.render();
  // # ADAPPT
}

void mousePressed() {
  viewer.mousePress();
  data.mousePress();
}
void mouseDragged() {
  data.mouseMove();
}
void mouseReleased() {
  data.mouseRelease();
}
void keyPressed() {
  data.keyPress(keyCode);
  input.keyPress();
}
void keyReleased() {
  data.keyRelease(keyCode);
  input.keyRelease();
}
