void drawMenu() {      //Drawing menu | Отрисовка 
  //background(bckg);
  MenuBack.drawBackGround();
  newBttn.enable = true;
  openBttn.enable = true;
  exitBttn.enable = true;
  
  //Проверка наводки мыши на кнопку открытия существующей новеллы
  if (openBttn.aimCheck() || (listBttn.aimCheck() && listBttn.enable)) {
    listBttn.enable = true;
    game1.enable = true;
  } else {
    listBttn.enable = false;
    game1.enable = false;
  }

  //Проверка нажатия на кнопку новеллы
  if (game1.clickCheck()) {
    mode = 2;
  }
  
  //Проверка нажатия на кнопку создания новой новеллы
  if (newBttn.clickCheck()) {
    mode = 1;
  }
  
  //Проверка нажатия на кнопку выхода
  if (exitBttn.clickCheck()){
    exit();
  }
  
  //Обновление случая отрисовки в зависимости от enable
  listBttn.update();
  newBttn.update();
  
  openBttn.update();
  game1.update();
  exitBttn.update();
  
  image(imgNew, width / 5, height / 6, width / 3.4, height / 6);
}
