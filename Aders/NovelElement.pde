class NovelElement {
  public PApplet ctx;
  public String id;
  public int x = width / 2 - 130, y = 0;

  public NovelElement() {}
  public NovelElement(PApplet ctx) {
    this.ctx = ctx;
  }
  public int getX() { // Get X position on screen
    return x;
  }
  public int getY() { // Get Y position on screen
    return y;
  }
  
  public int getHeight() { // Get element height
    return Config.ID_SIZE;
  }
  public void render(int camx, int camy) { // Render all dis stuf
    int x = this.x + camx, y = this.y + camy;
    int offsetx = 2, offsety = 2;
    
    fill(Config.BLOCK);
    stroke(Config.BLOCK_BORDER);
    strokeWeight(1);
    rect(x, y, Config.BLOCK_W, getHeight(), 5);
    
    offsety += Config.ID_SIZE;
    fill(Config.BLOCK_TEXT);
    textSize(Config.ID_SIZE);
    String txt = Utils.wrap(ctx, id);
    text(txt, x + offsetx, y + offsety);
  }
}

class StartElement extends NovelElement {
  public String name = "", text = "", next = "";
  
  public StartElement(PApplet ctx, String next) { // Create new instance of TextElement using UUID, text and next element id
    this.ctx = ctx;
    this.next = next;
  }
  
  public int getHeight() { // Get element height
    return Config.INDENT + Config.TITLE_SIZE;
  }
  public void render(int camx, int camy) { // Render all dis stuf
    int x = this.x + camx, y = this.y + camy;
    int offsetx = 2, offsety = 2;
    
    fill(Config.BLOCK);
    stroke(#FF0000);
    strokeWeight(1);
    rect(x, y, Config.BLOCK_W, getHeight(), 5);
    
    offsety += Config.TITLE_SIZE;
    textSize(Config.TITLE_SIZE);
    String txt = Utils.wrap(ctx, "[ НАЧАЛО ]");
    text(txt, x + Config.BLOCK_W / 2 - textWidth(txt) / 2, y + offsety);
  }
}

class TextElement extends NovelElement {
  public String name = "", text = "", next = "";
  
  public TextElement(PApplet ctx, String id, String name, String text, String next) { // Create new instance of TextElement using UUID, text and next element id
    this.ctx = ctx;
    this.id = id;
    this.name = name;
    this.text = text;
    this.next = next;
  }
  
  public int getHeight() { // Get element height
    return Config.INDENT + Config.ID_SIZE + Config.TITLE_SIZE + Config.TEXT_SIZE;
  }
  public void render(int camx, int camy) { // Render all dis stuf
    int x = this.x + camx, y = this.y + camy;
    int offsetx = 2, offsety = 2;
    
    fill(Config.BLOCK);
    stroke(Config.BLOCK_BORDER);
    strokeWeight(1);
    rect(x, y, Config.BLOCK_W, getHeight(), 5);
    
    offsety += Config.ID_SIZE;
    fill(Config.BLOCK_TEXT);
    textSize(Config.ID_SIZE);
    String txt = Utils.wrap(ctx, id);
    text(txt, x + offsetx, y + offsety);
    
    offsety += Config.TITLE_SIZE;
    textSize(Config.TITLE_SIZE);
    txt = Utils.wrap(ctx, "Текст");
    text(txt, x + Config.BLOCK_W / 2 - textWidth(txt) / 2, y + offsety);
    
    offsety += Config.TEXT_SIZE;
    textSize(Config.TEXT_SIZE);
    txt = Utils.wrap(ctx, "(" + name + ") " + text);
    text(txt, x + Config.BLOCK_W / 2 - textWidth(txt) / 2, y + offsety);
  }
}

class ChoiceElement extends NovelElement {
  public String text = "";
  public NovelOption[] options;
  
  public ChoiceElement(PApplet ctx, String id, String text, JSONArray options) { // Create new instance of ChoiceElement using UUID, text and raw options from JSON file
    this.ctx = ctx;
    this.id = id;
    this.text = text;
    loadOptions(options);
  }
  public void loadOptions(JSONArray jarr) { // Parse raw options and save as NovelOption array
    options = new NovelOption[jarr.size()];
    for(int i = 0; i < jarr.size(); i++) {
      options[i] = new NovelOption(jarr.getJSONObject(i).getString("text"), jarr.getJSONObject(i).getString("next"));
    }
  }
  public int getHeight() { // Get element height
    return Config.INDENT + Config.ID_SIZE + Config.TITLE_SIZE + Config.TEXT_SIZE + Config.TEXT_SIZE * options.length;
  }
  public void render(int camx, int camy) { // Render all dis stuf
    int x = this.x + camx, y = this.y + camy;
    int offsetx = 2, offsety = 2;
    
    fill(Config.BLOCK);
    stroke(Config.BLOCK_BORDER);
    strokeWeight(1);
    rect(x, y, Config.BLOCK_W, getHeight(), 5);
    
    offsety += Config.ID_SIZE;
    fill(Config.BLOCK_TEXT);
    textSize(Config.ID_SIZE);
    String txt = Utils.wrap(ctx, id);
    text(txt, x + offsetx, y + offsety);
    
    offsety += Config.TITLE_SIZE;
    textSize(Config.TITLE_SIZE);
    txt = Utils.wrap(ctx, "Выбор");
    text(txt, x + Config.BLOCK_W / 2 - textWidth(txt) / 2, y + offsety);
    
    offsety += Config.TEXT_SIZE;
    textSize(Config.TEXT_SIZE);
    txt = Utils.wrap(ctx, text);
    text(txt, x + Config.BLOCK_W / 2 - textWidth(txt) / 2, y + offsety);
    
    textSize(Config.TEXT_SIZE);
    for(int i = 0; i < options.length; i++) {
      NovelOption option = options[i];
      offsety += Config.TEXT_SIZE;
      fill(Config.OPTIONS[i]);
      txt = Utils.wrap(ctx, option.text + " >> " + option.next);
      text(txt, x + offsetx, y + offsety);
    }
  }
}

class BackgroundElement extends NovelElement {
  public String res = "", next = "";
  
  public BackgroundElement(PApplet ctx, String id, String res, String next) { // Create new instance of BackgroundElement using UUID, resource ID and next element ID
    this.ctx = ctx;
    this.id = id;
    this.res = res;
    this.next = next;
  }
  public int getHeight() { // Get element height
    return Config.INDENT + Config.ID_SIZE + Config.TITLE_SIZE + Config.TEXT_SIZE;
  }
  public void render(int camx, int camy) { // Render all dis stuf
    int x = this.x + camx, y = this.y + camy;
    int offsetx = 2, offsety = 2;
    
    fill(Config.BLOCK);
    stroke(Config.BLOCK_BORDER);
    strokeWeight(1);
    rect(x, y, Config.BLOCK_W, getHeight(), 5);
    
    offsety += Config.ID_SIZE;
    fill(Config.BLOCK_TEXT);
    textSize(Config.ID_SIZE);
    String txt = Utils.wrap(ctx, id);
    text(txt, x + offsetx, y + offsety);
    
    offsety += Config.TITLE_SIZE;
    textSize(Config.TITLE_SIZE);
    txt = Utils.wrap(ctx, "Фон");
    text(txt, x + Config.BLOCK_W / 2 - textWidth(txt) / 2, y + offsety);
    
    offsety += Config.TEXT_SIZE;
    textSize(Config.TEXT_SIZE);
    txt = Utils.wrap(ctx, res);
    text(txt, x + Config.BLOCK_W / 2 - textWidth(txt) / 2, y + offsety);
  }
}

class SpriteElement extends NovelElement {
  public static final int A_SHOW = 0, A_HIDE = 1;
  public String name = "", res = "", next = "";
  public int action;
  
  public SpriteElement(PApplet ctx, String id, String name, int action, String res, String next) { // Dont use it. Just dont.
    this.ctx = ctx;
    this.id = id;
    this.name = name;
    this.action = action;
    this.res = res;
    this.next = next;
  }
  public int getHeight() { // Get element height
    return Config.INDENT + Config.ID_SIZE + Config.TITLE_SIZE + Config.TEXT_SIZE + Config.TEXT_SIZE + Config.TEXT_SIZE;
  }
  public void render(int camx, int camy) { // Render all dis stuf
    int x = this.x + camx, y = this.y + camy;
    int offsetx = 2, offsety = 2;
    
    fill(Config.BLOCK);
    stroke(Config.BLOCK_BORDER);
    strokeWeight(1);
    rect(x, y, Config.BLOCK_W, getHeight(), 5);
    
    offsety += Config.ID_SIZE;
    fill(Config.BLOCK_TEXT);
    textSize(Config.ID_SIZE);
    String txt = Utils.wrap(ctx, id);
    text(txt, x + offsetx, y + offsety);
    
    offsety += Config.TITLE_SIZE;
    textSize(Config.TITLE_SIZE);
    txt = Utils.wrap(ctx, "Спрайт");
    text(txt, x + Config.BLOCK_W / 2 - textWidth(txt) / 2, y + offsety);
    
    offsety += Config.TEXT_SIZE;
    textSize(Config.TEXT_SIZE);
    txt = "lolwat";
    switch(action) {
      case A_SHOW:
        txt = "Показать";
        break;
      case A_HIDE:
        txt = "Скрыть";
        break;
    }
    txt += " : " + name;
    text(txt, x + Config.BLOCK_W / 2 - textWidth(txt) / 2, y + offsety);
    
    offsety += Config.TEXT_SIZE;
    textSize(Config.TEXT_SIZE);
    txt = res;
    text(txt, x + Config.BLOCK_W / 2 - textWidth(txt) / 2, y + offsety);
  }
}
