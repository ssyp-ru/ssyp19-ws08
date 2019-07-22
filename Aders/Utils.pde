static class Utils {
  public static boolean collide(int x1, int y1, int w1, int h1, int x2, int y2, int w2, int h2) { // Collide two boxes
    return x1 < x2 + w2 && x1 + w1 > x2 && y1 < y2 + h2 && y1 + h1 > y2;
  }
  public static String wrap(PApplet ctx, String text) { // Cut string to width
    for(int i = 0; i < (text).length(); i++) {
      if(ctx.textWidth((text).substring(0, i)) + ctx.textWidth("...") >= Config.BLOCK_W) return text.substring(0, max(0, i - 1)) + "...";
    }
    return text;
  }
  public static String UUID() { // Generate UUID
    return Generators.randomBasedGenerator().generate().toString();
  }
}
