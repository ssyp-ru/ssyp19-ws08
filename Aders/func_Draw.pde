void draw() {
  //Update statement

  if (mode == 0) {      //Menu
    drawMenu();
  }

  if (mode == 1) {      //New
    drawNew();
  }

  if (mode == 2) {      //Play
    //drawNovel();
    viewer.render();
  }
}
