// Camera
float angle = 0;
float xRotation, yRotation = 0;

PGraphics pg;
Mesh mesh;

TapeDeck tapeDeck;
boolean face;

void setup() 
{  
  size(800, 800, OPENGL);
  frameRate(60);
  colorMode(HSB);
  println(this.getClass());
  mesh = new Mesh(this);
 
  tapeDeck = new TapeDeck(this, "01 No Partial.mp3");
  tapeDeck.play();
}

void draw() 
{
  background(255);
  lights();
  smooth();
  translate(width/2, height/2);
  rotate();
  mesh.drawMesh();
  setLights();
}

void rotate() 
{
  rotateY(yRotation);
  rotateX(xRotation);  
  yRotation += 0.01;
  xRotation += 0.05;
}

void setLights()
{
  directionalLight(120, 0, 10, -1, -1, 1);
  directionalLight(120, 255, 50, 1, 1, -1);
}
