class NovelData {
  PApplet ctx;
  String[] meta;
  NovelResource[] arrResources;
  NovelElement[] arrElements;
  StartElement startElement;
  Input editInput;
  
  int camx = 0, camy = 0;
  int moving = -1, mdiffx = 0, mdiffy = 0;
  boolean moved = false;
  
  boolean sel1 = false, sel2 = false;
  int[] pos1 = new int[2], pos2 = new int[2];
  
  HashMap<Integer, Boolean> keys = new HashMap<Integer, Boolean>();
  TextConfigurator text;
  
  String filename;
  
  public NovelData(PApplet ctx, String path) { // Create new instance of NovelData from file and context
    this.ctx = ctx;
    load(path);
  }
  public void load(String path) { // Load and import novel from JSON file
    filename = path;
    String json = String.join("", loadStrings(path));
    JSONObject raw = parseJSONObject(json);
    JSONObject rawMeta = raw.getJSONObject("meta");
    JSONObject rawResources = raw.getJSONObject("resources");
    JSONObject rawElements = raw.getJSONObject("elements");
    
    meta = new String[] { rawMeta.getString("name"), rawMeta.getString("author"), rawMeta.getString("start") };
    
    startElement = new StartElement(ctx, meta[2]);
    
    arrResources = new NovelResource[rawResources.size()];
     for(int i = 0; i < rawResources.size(); i++) {
      String id = (String)rawResources.keys().toArray()[i];
      JSONObject resource = rawResources.getJSONObject(id);
      switch(resource.getString("type")) {
        case "background":
          arrResources[i] = new NovelResource(id, NovelResource.T_BACKGROUND, resource.getString("data"), resource.getString("ext"));
          break;
        case "sprite":
          arrResources[i] = new NovelResource(id, NovelResource.T_SPRITE, resource.getString("data"), resource.getString("ext"));
          break;
        case "sound":
          arrResources[i] = new NovelResource(id, NovelResource.T_SOUND, resource.getString("data"), resource.getString("ext"));
          break;
      }
    }
    
    arrElements = new NovelElement[rawElements.size()];
    for(int i = 0; i < rawElements.size(); i++) {
      String id = (String)rawElements.keys().toArray()[i];
      JSONObject element = rawElements.getJSONObject(id);
      switch(element.getString("type")) {
        case "text":
          arrElements[i] = new TextElement(ctx, id, element.getString("name"), element.getString("text"), element.getString("next"));
          break;
        case "choice":
          arrElements[i] = new ChoiceElement(ctx, id, element.getString("text"), element.getJSONArray("options"));
          break;
        case "background":
          arrElements[i] = new BackgroundElement(ctx, id, element.getString("res"), element.getString("next"));
          break;
        case "sprite":
          arrElements[i] = new SpriteElement(ctx, id, element.getString("name"), element.getString("action").equals("show") ? SpriteElement.A_SHOW : SpriteElement.A_HIDE, element.getString("res"), element.getString("next"));
          break;
        case "sound":
          //
          break;
      }
    }
  }
  public void save(String path) { // Save novel to JSON file
    JSONObject raw = new JSONObject();
    JSONObject rawMeta = new JSONObject();
    JSONObject rawResources = new JSONObject();
    JSONObject rawElements = new JSONObject();
    
    rawMeta.put("name", meta[0]);
    rawMeta.put("author", meta[1]);
    rawMeta.put("start", startElement.next);
    raw.put("meta", rawMeta);
    
    for(NovelResource resource : arrResources) {
      JSONObject obj = new JSONObject();
      switch(resource.type) {
        case NovelResource.T_BACKGROUND:
          obj.put("type", "background");
          break;
        case NovelResource.T_SPRITE:
          obj.put("type", "sprite");
          break;
        case NovelResource.T_SOUND:
          obj.put("type", "sound");
          break;
      }
      obj.put("data", resource.base64);
      rawResources.put(resource.id, obj);
    }
    raw.put("resources", rawResources);
    
    for(NovelElement element : arrElements) {
      if(element instanceof TextElement) {
        TextElement el = (TextElement)element;
        JSONObject obj = new JSONObject();
        obj.put("type", "text");
        obj.put("name", el.name);
        obj.put("text", el.text);
        obj.put("next", el.next);
        rawElements.put(el.id, obj);
      } else if(element instanceof ChoiceElement) {
        ChoiceElement el = (ChoiceElement)element;
        JSONObject obj = new JSONObject();
        obj.put("type", "choice");
        obj.put("text", el.text);
        JSONArray options = new JSONArray();
        for(NovelOption opt : el.options) {
          JSONObject option = new JSONObject();
          option.put("text", opt.text);
          option.put("next", opt.next);
          options.setJSONObject(options.size(), option);
        }
        obj.put("options", options);
        rawElements.put(el.id, obj);
      } else if(element instanceof BackgroundElement) {
        BackgroundElement el = (BackgroundElement)element;
        JSONObject obj = new JSONObject();
        obj.put("type", "background");
        obj.put("res", el.res);
        obj.put("next", el.next);
        rawElements.put(el.id, obj);
      } else if(element instanceof SpriteElement) {
        SpriteElement el = (SpriteElement)element;
        JSONObject obj = new JSONObject();
        obj.put("type", "sprite");
        obj.put("name", el.name);
        obj.put("action", el.action == SpriteElement.A_SHOW ? "show" : "hide");
        obj.put("res", el.res);
        obj.put("next", el.next);
        rawElements.put(el.id, obj);
      }  
    }
    raw.put("elements", rawElements);
    
    try {
      String text = raw.format(4);
      OutputStreamWriter writer = new OutputStreamWriter(new FileOutputStream(path), StandardCharsets.UTF_8);
      writer.write(text, 0, text.length());
      writer.flush();
    } catch(Exception e) {
      e.printStackTrace();
    }
  }
  
  public void mousePress() { // Handle mouse press (element movement)
    switch(mouseButton) {
      case LEFT:
        for(int i = arrElements.length - 1; i >= 0; i--) {
          if(Utils.collide(arrElements[i].x + camx, arrElements[i].y + camy, Config.BLOCK_W, arrElements[i].getHeight(), mouseX, mouseY, 1, 1)) {
            makeFirst(i);
            i = arrElements.length - 1;
            moving = i;
            mdiffx = arrElements[i].x - mouseX;
            mdiffy = arrElements[i].y - mouseY;
            return;
          }
        }
        break;
      case RIGHT:
        if(!sel1 && !sel2) {
          sel1 = true;
          pos1 = new int[] { mouseX - camx, mouseY - camy };
        } else if(sel1 && !sel2) {
          sel2 = true;
          pos2 = new int[] { mouseX - camx, mouseY - camy };
        } else if(sel1 && sel2) connectSel();
        break;
    }
  }
  public void mouseMove() { // Handle mouse move (element movement)
    if(moving == -1) return;
    moved = true;
    arrElements[moving].x = mouseX + mdiffx;
    arrElements[moving].y = mouseY + mdiffy;
  }
  public void mouseRelease() { // Handle mouse release (element movement)
    if(moving != -1 && !moved) edit(moving);
    moved = false;
    moving = -1;
  }
  public void keyPress(int keyCode) { // Handle key press
    if(editInput != null) editInput.keyPress();
    keys.put(keyCode, true);
    try {
      if(keys.get(17) == true && keyCode == 83) save(dataPath("") + "/" + filename);
    } catch(Exception e) {}
  }
  public void keyRelease(int keyCode) { // Handle key press
    if(editInput != null) editInput.keyRelease();
    keys.put(keyCode, false);
  }
  
  public void addElement(NovelElement element) { // Add element to array
    arrElements = (NovelElement[])splice(arrElements, element, arrElements.length);
    save(dataPath("") + "/" + filename);
  }
  public void addResource(NovelResource resource) { // Add resource to array
    arrResources = (NovelResource[])splice(arrResources, resource, arrResources.length);
    save(dataPath("") + "/" + filename);
  }
  public void edit(int index) {
    NovelElement element = arrElements[index];
    if(element instanceof TextElement) {
      final TextElement el = (TextElement)element;
      editInput = new Input("Имя", 200, 200, 200);
      editInput.show = true;
      editInput.setCallback(new InputCallback() {
        public void finish(String txt) {
          el.name = txt;
          editInput.show = false;
          editInput = new Input("Текст", 200, 200, 200);
          editInput.show = true;
          editInput.setCallback(new InputCallback() {
            public void finish(String txt) {
              el.text = txt;
              editInput.show = false;
              editInput = null;
            }
            public void fail(String txt) {}
          });
        }
        public void fail(String txt) {}
      });
    }
  }
  public void makeFirst(int index) { // Move nth element
    NovelElement target = arrElements[index];
    arrElements[index] = null;
    for(int i = index + 1; i < arrElements.length; i++) {
      if(arrElements[i - 1] == null) arrElements[i - 1] = arrElements[i];
      arrElements[i] = null;
    }
    arrElements[arrElements.length - 1] = target;
  }
  
  public void tick() { // Tick
    if(keys.containsKey(38) && keys.get(38) == true) camy += Config.CAM_SPEED;
    if(keys.containsKey(40) && keys.get(40) == true) camy -= Config.CAM_SPEED;
    if(keys.containsKey(37) && keys.get(37) == true) camx += Config.CAM_SPEED;
    if(keys.containsKey(39) && keys.get(39) == true) camx -= Config.CAM_SPEED;
  }
  public void render() { // Render elements
    renderSel();
    startElement.render(camx, camy);
    if(isElement(startElement.next)) renderConnectionStart(findIndexById(startElement.next));
    for(int i = 0; i < arrElements.length; i++) {
      NovelElement element = arrElements[i];
      element.render(camx, camy);
      if(element instanceof TextElement) {
        TextElement el = (TextElement)element;
        if(isElement(el.next))
          renderConnection(findIndexById(el.id), findIndexById(el.next), Config.ARROW);
      } else if(element instanceof ChoiceElement) {
        ChoiceElement el = (ChoiceElement)element;
        for(int j = 0; j < el.options.length; j++) {
          NovelOption option = el.options[j];
          if(isElement(option.next))
            renderConnection(findIndexById(el.id), findIndexById(option.next), Config.OPTIONS[j]);
        }
      } else if(element instanceof BackgroundElement) {
        BackgroundElement el = (BackgroundElement)element;
        if(isElement(el.next))
          renderConnection(findIndexById(el.id), findIndexById(el.next), Config.ARROW);
      } else if(element instanceof SpriteElement) {
        SpriteElement el = (SpriteElement)element;
        if(isElement(el.next))
          renderConnection(findIndexById(el.id), findIndexById(el.next), Config.ARROW);
      }
    }
    
    if(editInput != null) editInput.render();
  }
  
  public void renderSel() { // Render selection
    if(sel1 && !sel2) {
      stroke(Config.SELECTION);
      fill(Config.SELECTION);
      line(camx + pos1[0], camy + pos1[1], mouseX, mouseY);
    } else if(sel1 && sel2) {
      stroke(Config.SELECTION);
      fill(Config.SELECTION);
      line(camx + pos1[0], camy + pos1[1], camx + pos2[0], camy + pos2[1]);
    }
  }
  public void connectSel() { // Connect selected elements
    int e1 = -1, e2 = -1;
    for(int i = arrElements.length - 1; i >= 0; i--) {
      if(Utils.collide(arrElements[i].x, arrElements[i].y, Config.BLOCK_W, arrElements[i].getHeight(), pos1[0], pos1[1], 1, 1) && e1 == -1) e1 = i;
      else if(Utils.collide(arrElements[i].x, arrElements[i].y, Config.BLOCK_W, arrElements[i].getHeight(), pos2[0], pos2[1], 1, 1) && e2 == -1) e2 = i;
    }
    sel1 = false; sel2 = false;
    if(Utils.collide(startElement.x, startElement.y, Config.BLOCK_W, startElement.getHeight(), pos1[0], pos1[1], 1, 1)) {
      if(e2 != -1) startElement.next = arrElements[e2].id;
      return;
    }
    if(e1 == -1 || e2 == -1) return;
    if(arrElements[e1] instanceof TextElement) {
      ((TextElement)arrElements[e1]).next = arrElements[e2].id;
    } else if(arrElements[e1] instanceof BackgroundElement) {
      ((BackgroundElement)arrElements[e1]).next = arrElements[e2].id;
    } else if(arrElements[e1] instanceof SpriteElement) {
      ((SpriteElement)arrElements[e1]).next = arrElements[e2].id;
    }
  }
  public void renderConnectionStart(int i) {
    NovelElement e1 = startElement, e2 = arrElements[i];
    int x1 = e1.x, x2 = e2.x, y1 = e1.y, y2 = e2.y;
    int p1x = Integer.MIN_VALUE, p2x = Integer.MIN_VALUE, p1y = Integer.MIN_VALUE, p2y = Integer.MIN_VALUE;
    if(y2 > y1 + e1.getHeight()) {
      p1x = x1 + Config.BLOCK_W / 2;
      p2x = x2 + Config.BLOCK_W / 2;
      p1y = y1 + e1.getHeight();
      p2y = y2;
    } else if(y1 > y2 + e2.getHeight()) {
      p1x = x1 + Config.BLOCK_W / 2;
      p2x = x2 + Config.BLOCK_W / 2;
      p1y = y1;
      p2y = y2 + e2.getHeight();
    } else if(x2 > x1 + Config.BLOCK_W) {
      p1x = x1 + Config.BLOCK_W;
      p2x = x2;
      p1y = y1 + e1.getHeight() / 2;
      p2y = y2 + e2.getHeight() / 2;
    } else if(x1 > x2 + Config.BLOCK_W) {
      p1x = x1;
      p2x = x2 + Config.BLOCK_W;
      p1y = y1 + e1.getHeight() / 2;
      p2y = y2 + e2.getHeight() / 2;
    }
    stroke(Config.ARROW);
    fill(Config.ARROW);
    strokeWeight(3);
    line(camx + p1x, camy + p1y, camx + p2x, camy + p2y);
    pushMatrix();
    translate(camx + p2x, camy + p2y);
    rotate(atan2(p1x - p2x, p2y - p1y));
    line(0, 0, -10, -10);
    line(0, 0, 10, -10);
    popMatrix();
  }
  public void renderConnection(int i1, int i2, color clr) { // Render connections
    NovelElement e1 = arrElements[i1], e2 = arrElements[i2];
    int x1 = e1.x, x2 = e2.x, y1 = e1.y, y2 = e2.y;
    int p1x = Integer.MIN_VALUE, p2x = Integer.MIN_VALUE, p1y = Integer.MIN_VALUE, p2y = Integer.MIN_VALUE;
    if(y2 > y1 + e1.getHeight()) {
      p1x = x1 + Config.BLOCK_W / 2;
      p2x = x2 + Config.BLOCK_W / 2;
      p1y = y1 + e1.getHeight();
      p2y = y2;
    } else if(y1 > y2 + e2.getHeight()) {
      p1x = x1 + Config.BLOCK_W / 2;
      p2x = x2 + Config.BLOCK_W / 2;
      p1y = y1;
      p2y = y2 + e2.getHeight();
    } else if(x2 > x1 + Config.BLOCK_W) {
      p1x = x1 + Config.BLOCK_W;
      p2x = x2;
      p1y = y1 + e1.getHeight() / 2;
      p2y = y2 + e2.getHeight() / 2;
    } else if(x1 > x2 + Config.BLOCK_W) {
      p1x = x1;
      p2x = x2 + Config.BLOCK_W;
      p1y = y1 + e1.getHeight() / 2;
      p2y = y2 + e2.getHeight() / 2;
    }
    stroke(clr);
    fill(clr);
    strokeWeight(3);
    line(camx + p1x, camy + p1y, camx + p2x, camy + p2y);
    pushMatrix();
    translate(camx + p2x, camy + p2y);
    rotate(atan2(p1x - p2x, p2y - p1y));
    line(0, 0, -10, -10);
    line(0, 0, 10, -10);
    popMatrix();
  }
  public int findIndexById(String id) { // Find index of element by its ID
    for(int i = 0; i < arrElements.length; i++)
      if(arrElements[i].id.equals(id))
        return i;
    return -1;
  }
  public boolean isElement(String id) { // Check if element exists and isn't virtual
    return !id.startsWith("_") && findIndexById(id) != -1;
  }
}
