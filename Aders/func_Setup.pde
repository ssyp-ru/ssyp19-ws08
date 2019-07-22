NovelViewer viewer;
NovelData data;

Button addTextEl;
//Button addChoiceEl;
Button addBackgroundEl;
Button addSpriteEl;
//Button addSoundEl;
Button btnPlay;

PImage imgNew;
PImage imgBackground;
PImage imgSprite;
PImage imgSound;

void settings() {
  fullScreen();
}

void setup(){
  
  background(bckg);
  textSize(32);
  frameRate(60);
  
  
  for (int i = 0; i< CONST; i++) cntrs[i] = -1;

  //Creating objects
  newBttn = new Bttn(width / 5, height / 6, width / 3.4, height / 6, 15);
  openBttn = new Bttn(width / 5, height / 2.4, width / 3.4, height / 6, 15);
  listBttn = new Bttn(width / 2.0265, height / 8, width / 2.6, height / 1.8, 15);
  
  imgNew = loadImage("new_bt.PNG");
  imgBackground = loadImage("new_background.PNG");
  imgSprite = loadImage("new_sprite.PNG");
  imgSound = loadImage("new_sound.PNG");
  imgBackground.resize(width / 20, height / 20);
  imgSprite.resize(width / 20, height / 20);
  imgSound.resize(width / 20, height / 20);

  game1 = new Bttn(width / 1.9, height / 6, width / 3.4, height/ 12, 10);

  addSprite = new Bttn(15, height / 40, width / 20, height / 20, 25);
  addBackground = new Bttn(15, height / 1.9, width / 20, height / 20, 25);
  addCounter = new Bttn(width / 1.166667 + 15, height / 40, width / 20, height / 20, 25);
  addSound = new Bttn(width / 1.166667 + 15, height / 1.9, width / 20, height / 20, 25);

  spriteList = new Bttn(0, 0, width / 7, height / 2, 0);
  backgroundList = new Bttn(0, height / 2, width / 7, height / 2, 0);
  charList = new Bttn(width / 7 * 6, 0, width / 7, height / 2, 0);
  soundList = new Bttn(width / 7 * 6, height / 2, width / 7, height / 2, 0);

  importSprite = new Bttn(0, 0, width, height, 45);
  importBackground = new Bttn(0, 0, width, height, 45);
  importCounter = new Bttn(0, 0, width, height, 45);
  importSound = new Bttn(0, 0, width, height, 45);
  
  input = new Input("Enter name:", width / 5, height / 5, 500);
  
  spriteAdded = new Bttn(width / 1.5, height / 2, width / 10, height / 10, 10);
  backgroundAdded = new Bttn(width / 1.5, height / 2, width / 10, height / 10, 10);
  counterAdded = new Bttn(width / 1.5, height / 2, width / 10, height / 10, 10);
  soundAdded = new Bttn(width / 1.5, height / 2, width / 10, height / 10, 10);
  
  textWindow = new Bttn(20, height / 1.435, width - 40, height / 3.3, 0);
  exitMenu = new Bttn(width / 35, height / 35, width / 10, height / 15, 15);
  openSettings = new Bttn(width / 7, height / 35, width / 10, height / 15, 15);
  Settings = new Bttn(width / 7, height / 10.5, width / 2.43, height / 2.5, 15);
  
  soundMore = new Bttn(width / 2.5, height / 5, width / 10, height / 10, 10);
  soundLess = new Bttn(width / 5, height / 5, width / 10, height / 10, 10);
  
  EditPlayBack = new BackGround("PlayEditBack.jpg");
  MenuBack = new BackGround("MenuBack.jpg");
  //Char = new Sprite("Character.png");
  
  exitBttn = new Bttn(width / 1.1, height / 1.1, width / 15, height / 15, 15);
  
  choice1 = new Bttn(width / 3, height / 5, width / 3, height / 10, 15);
  choice2 = new Bttn(width / 3, height / 3.2, width / 3, height / 10, 15);
  choice3 = new Bttn(width / 3, height / 2.35, width / 3, height / 10, 15);
  choice4 = new Bttn(width / 3, height / 1.85, width / 3, height / 10, 15);
  choice5 = new Bttn(width / 3, height / 1.535, width / 3, height / 10, 15);
  choiceList = new Bttn(width / 4, height / 6, width / 2, height / 1.5, 0);
  
  //vn
  data = new NovelData(this, "example.txt");
  addTextEl = new Button(220, 10, 64, 36, 5);
  addTextEl.enable = true;
  addTextEl.setCallback(new ButtonCallback() {
    public void clickChange(boolean clicked) {
      if(clicked) {
        TextElement el = new TextElement(Aders.this, Utils.UUID(), "name", "text", "_exit");
        data.addElement(el);
      }
    }
    public void hoverChange(boolean hovered) {}
  });
  addBackgroundEl = new Button(220, 10 + 36 + 10, 64, 36, 5);
  addBackgroundEl.enable = true;
  addBackgroundEl.setCallback(new ButtonCallback() {
    public void clickChange(boolean clicked) {
      if(clicked) {
        BackgroundElement el = new BackgroundElement(Aders.this, Utils.UUID(), "file", "_exit");
        data.addElement(el);
      }
    }
    public void hoverChange(boolean hovered) {}
  });
  addSpriteEl = new Button(220, 10 + 36 + 10 + 36 + 10, 64, 36, 5);
  addSpriteEl.enable = true;
  addSpriteEl.setCallback(new ButtonCallback() {
    public void clickChange(boolean clicked) {
      if(clicked) {
        SpriteElement el = new SpriteElement(Aders.this, Utils.UUID(), "0", SpriteElement.A_SHOW, "file", "_exit");
        data.addElement(el);
      }
    }
    public void hoverChange(boolean hovered) {}
  });
  btnPlay = new Button(width - 64 - 220, height - 10 - 36, 64, 36, 5);
  btnPlay.enable = true;
  btnPlay.setCallback(new ButtonCallback() {
    public void clickChange(boolean clicked) {
      mode = 2;
      viewer.enabled = true;
      if(clicked) viewer.nextFrame();
    }
    public void hoverChange(boolean hovered) {}
  });
  
  viewer = new NovelViewer(data);
}
