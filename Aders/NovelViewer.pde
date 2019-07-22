class NovelViewer {
  NovelData data;
  PImage background;
  PImage sprite;
  String text;
  String curId;
  
  boolean enabled = false;
  int choice = 0;
  String[] nextIds;
  
  public NovelViewer(NovelData data) {
    this.data = data;
    choice = 0;
    nextIds = new String[] { data.meta[2] };
  }
  public void nextFrame() {
    curId = nextIds[choice];
    parseCurElement();
  }
  public void render() {
    if(background != null) {
      image(background, 0, 0, width, height);
    }
    if(sprite != null) {
      image(sprite, width / 2 - (width / Config.SPRITE_W) / 2, height - (height / Config.SPRITE_H), width / Config.SPRITE_W, height / Config.SPRITE_H);
    }
    if(text != null && text != "") {
      fill(255);
      rect(Config.TEXT_M, height - (height / Config.TEXT_H) - Config.TEXT_M, width - Config.TEXT_M * 2, width / Config.TEXT_H);
      fill(0);
      text(text, Config.TEXT_M, height - (height / Config.TEXT_H) - Config.TEXT_M + Config.TEXT_S);
    }
  }
  public void parseCurElement() {
    if(curId.equals("_exit")) mode = 1;
    else if(!data.isElement(curId)) println("Element not found");
    else {
      int index = data.findIndexById(curId);
      NovelElement el = data.arrElements[index];
      if(el instanceof TextElement) {
        TextElement elText = (TextElement)el;
        text = elText.name +"\n" + elText.text;
        choice = 0;
        nextIds = new String[] { elText.next };
      } else if(el instanceof ChoiceElement) {
        ChoiceElement elChoice = (ChoiceElement)el;
        text = "";
        choice = 0;
        nextIds = new String[elChoice.options.length];
        for(int i = 0; i < elChoice.options.length; i++) nextIds[i] = elChoice.options[i].next;
      } else if(el instanceof BackgroundElement) {
        BackgroundElement elBackground = (BackgroundElement)el;
        background = loadImage(elBackground.res);
        choice = 0;
        nextIds = new String[] { elBackground.next };
        nextFrame();
      } else if(el instanceof SpriteElement) {
        SpriteElement elSprite = (SpriteElement)el;
        switch(elSprite.action) {
          case SpriteElement.A_SHOW:
            sprite = loadImage(elSprite.res);
            break;
          case SpriteElement.A_HIDE:
            sprite = null;
            break;
        }
        choice = 0;
        nextIds = new String[] { elSprite.next };
        nextFrame();
      }
    //} else if(el instanceof SoundElement) {
      //  BackgroundElement elSound = (SoundElement)el;
      //  // do something
      //  choice = 0;
      //  nextIds = new String[] { elBackground.next };
      //}
    }
  }
  void mousePress() {
    if(enabled) nextFrame();
  }
}
