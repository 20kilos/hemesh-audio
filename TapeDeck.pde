import ddf.minim.analysis.*;
import ddf.minim.*;

class TapeDeck 
{
  private Minim  minim;
  private AudioPlayer player;
  
  TapeDeck(PApplet p, String fileName) 
  {
    minim = new Minim(p);
    player = minim.loadFile(fileName,128);
  }
  
  public void play()
  {
    player.play();
  }
  
  public float getAmplitude() 
  {
    float total = 1;
    int bufferSize = player.bufferSize();
    for(int i = 0; i < bufferSize - 1; i++) {
      total += player.mix.get(i);
    }
    return (total);
  }
}
