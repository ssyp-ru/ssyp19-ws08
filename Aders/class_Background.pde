class BackGround   //Работающий класс фонов
{
  PImage img;
  String name;
//нормально работающий конструктор для фонов(сразу создаёт img и растягивает по w и h)
  BackGround(String s)
  {
    img = loadImage((String)s);
    img.resize(width, height);
    name = s;
  }
//ыыы, рисуем
  void drawBackGround()
  {
    image(img, 0, 0);
  }
}
