SoundFile createSF(String n){
  return new SoundFile(this, n);
}

class Music{
  SoundFile song;
  String name;
  Music(String n){
    song = createSF(n);
    name = n;
  }
}
