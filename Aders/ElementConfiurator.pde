class TextConfigurator {
  int x, y, w, mode;
  boolean enable = true;
  
  TextElement el;
  
  Button chName;
  Button chText;
  
  Input input;
  
  public TextConfigurator(TextElement el, int x, int y, int w) {
    this.el = el;
    this.x = x;
    this.y = y;
    this.w = w;
    
    chName = new Button(x + Config.CONF_MARGIN, y + Config.CONF_MARGIN, w - Config.CONF_MARGIN * 2, Config.CONF_SIZE, 2);
    chName.enable = true;
    chName.setCallback(new ButtonCallback() {
      public void clickChange(boolean clicked) {
        if(!clicked) return;
        input.title = "Введите имя";
        input.show = true;
      }
      public void hoverChange(boolean released) {}
    });
    chText = new Button(x + Config.CONF_MARGIN, y + Config.CONF_MARGIN * 2 + Config.CONF_SIZE, w - Config.CONF_MARGIN * 2, Config.CONF_SIZE, 2);
    chText.enable = true;
    chName.setCallback(new ButtonCallback() {
      public void clickChange(boolean clicked) {
        if(!clicked) return;
        input.title = "Введите текст";
        input.show = true;
      }
      public void hoverChange(boolean released) {}
    });
  }
  
  public int getHeight() {
    return Config.CONF_MARGIN * 3 + Config.CONF_SIZE * 2;
  }
  
  public void render() {
    if(!enable) return;
    fill(Config.CONF_BG);
    noStroke();
    rect(x, y, w, getHeight());
    
    chName.render();
    chText.render();
  }
}
