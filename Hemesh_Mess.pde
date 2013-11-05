import wblut.math.*;
import wblut.processing.*;
import wblut.core.*;
import wblut.hemesh.*;
import wblut.geom.*;

import ddf.minim.analysis.*;
import ddf.minim.*;
// Camera
float angle = 0;
float xRotation, yRotation = 0;
// HMesh
HE_Mesh mesh;
HE_DynamicMesh dynMesh;

HEM_Noise noiseModifier;
WB_Render render;
HEM_Lattice lattice;

Minim  minim;
AudioPlayer player;

boolean face;

void setup() 
{  
  size(800, 800, OPENGL);
  frameRate(60);
  colorMode(HSB);
  createMesh();
  setupSound();
}

void draw() 
{
  background(255);
  lights();
  smooth();
  translate(width/2, height/2);
  rotate();
  drawMesh();
  setLights();
}

void drawMesh()
{
  lattice.setWidth(30).setDepth(5);
  dynMesh.update();
  noiseModifier.setDistance(getAmplitude());
  dynMesh.modify(noiseModifier);
  fill(143, 60, 70, 60);
  stroke(0);
  render.drawFaces(dynMesh);
}

void createMesh() 
{
  HEC_Sphere creator = new HEC_Sphere();
  creator.setRadius(150); 
  creator.setUFacets(8);
  creator.setVFacets(8);
  
  mesh = new HE_Mesh(creator); 
  dynMesh = new HE_DynamicMesh(mesh);
  dynMesh.add(new HEM_Extrude().setDistance(20));

  lattice = new HEM_Lattice().setWidth(10).setDepth(5);
  dynMesh.add(lattice);
 
  noiseModifier = new HEM_Noise();
  dynMesh.update();
  render = new WB_Render(this);
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

void setupSound() 
{
  minim = new Minim(this);
  player = minim.loadFile("01 No Partial.mp3",128);
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
