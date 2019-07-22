void drawNovel() {      //Drawing novels | Отрисовка игры
  background(bckg);
  EditPlayBack.drawBackGround();
  Char.drawSprite();
  textWindow.enable = true;
  exitMenu.enable = true;
  openSettings.enable = true;
  
  //Проверка на кол-во выборов
  choiceList.enable = true;
  choice1.enable = true;
  choice2.enable = true;
  if (numberOfChoices >= 3){
    choice3.enable = true;
  }
  else{
    choice3.enable = false;
  }
  if (numberOfChoices >= 4){
    choice4.enable = true;
  }
  else{
    choice4.enable = false;
  }
  if (numberOfChoices >= 5){
    choice5.enable = true;
  }
  else{
    choice5.enable = false;
  }
  
  if (choice3.clickCheck()){
    println("You choice 2");
  }
  if (choice2.clickCheck()){
    println("You choice 3");
  }
  if (choice1.clickCheck()){
    println("You choice 1");
  }
    
  textWindow.update();
  choiceList.update();
  choice1.update();
  choice2.update();
  choice3.update();
  choice4.update(); 
  choice5.update();
  exitMenu.update();
  openSettings.update();
  Settings.update();
  soundMore.update();
  soundLess.update();
  
  //Проверка нажатия на кнопку возврата в меню из проигрывания новеллы
  if (exitMenu.clickCheck()){
    mode = 0;
  }
  //Проверка нажатия, и наводки на настройки, (как со списком новелл)
  if (openSettings.clickCheck() || (Settings.aimCheck() && Settings.enable)){
    Settings.enable = true;
    soundMore.enable = true;
    soundLess.enable = true;
    
    if (soundMore.clickCheck()){
      println("volume++");
      delay(500);
      //Тут должен быть код с изменением звука
    }
    else if (soundLess.clickCheck()){
      println("volume--");
      delay(500);
      //Тут должен быть код с изменением звука
    }
  }
  else{
    Settings.enable = false;
    soundMore.enable = false;
    soundLess.enable = false;
  }
}
