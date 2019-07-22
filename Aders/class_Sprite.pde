class Sprite  //Рабочий класс спрайтов
{
  PImage img;
  String name;
//нормально работающий конструктор для спрайтов(сразу создаёт и увеличивает до 3/5 от высоты)
  Sprite(String s)
  {
    img = loadImage(s);
    int w = img.width;
    int h = img.height;
    float k = w /  h;
    h = width * 3 / 5;
    w = (int)(h * k);
    img.resize(w, h);
    name = s;
  }
//ыыы, рисуем
  void drawSprite()
  {
//рисуем по середине и впритык к нижней границе экрана
    int x = width / 2 - img.width / 2;
    int y = height - img.height;
    image(img, x, y);
  }
}
