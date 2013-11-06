import ddf.minim.analysis.*;
import ddf.minim.*;

class TapeDeck 
{
  Minim  minim;
  AudioPlayer player;
  
  TapeDeck(Object o, String fileName) 
  {
    minim = new Minim(o);
    player = minim.loadFile(fileName,128);
  }
  
  void play()
  {
    player.play();
  }
  
  float getAmplitude() 
  {
    float total = 1;
    int bufferSize = player.bufferSize();
    for(int i = 0; i < bufferSize - 1; i++) {
      total += player.mix.get(i);
    }
    return (total);
  }
}
