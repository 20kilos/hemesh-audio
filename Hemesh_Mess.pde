import controlP5.*;

import wblut.math.*;
import wblut.processing.*;
import wblut.core.*;
import wblut.hemesh.*;
import wblut.geom.*;

import ddf.minim.analysis.*;
import ddf.minim.*;

ControlP5 cp5;
int sliderValue = 100;
int sliderTicks1 = 100;

float angle = 0;
float xRotation, yRotation = 0;

HE_DynamicMesh dynMesh;
HEM_Noise modifier;
WB_Render render;
HEM_Lattice lattice;

Minim  minim;
AudioInput in;      

void setup() {
  size(800, 800, P3D);
  colorMode(HSB);
 
  createMesh();

  minim = new Minim(this);
  in = minim.getLineIn();
}

void draw() {
  background(240);
  lights();
  translate(400, 400);
  
  
  directionalLight(255, 120, 255, -1, -1, 1);
  directionalLight(10, 255, 50, 1, 1, -1);
  

  rotateY(yRotation);
  rotateX(xRotation);
  
  yRotation += 0.01;
  xRotation += 0.03;

  float d= map(mouseX, 0, width,0, 40);
  println(d);
  float w= map(mouseY, 0, width,0, 40);
  lattice.setWidth(d).setDepth(w);
  dynMesh.update();

  modifier=new HEM_Noise();
  modifier.setDistance(getNoiseLevel()/20);
  dynMesh.modify(modifier);


  noSmooth();
  noStroke();
  fill(143, 60, 70, 60);
  render.drawFaces(dynMesh);

  smooth();
  stroke(0);
  render.drawEdges(dynMesh);
}

void createMesh() {

  HE_Mesh cube=new HE_Mesh(new HEC_Cube().setEdge(400));  
  //a dynamic mesh is called with the base mesh as argument
  dynMesh = new HE_DynamicMesh(cube);

  //subdividors can be added implicitely, to be applied more than once it should be added again
  dynMesh.add(new HES_CatmullClark());

  //modifiers can be added implicitely
  dynMesh.add(new HEM_Extrude().setDistance(0).setChamfer(0.5));
  //However adding implicitely is not useful as the parameters can no longer be changed.
  //It is better to apply fixed modifiers to the base mesh before passing it through to
  //the HE_DynamicMesh. This way their overhead is avoided each update().

  //Modifiers or subdividors that are to be dynamic should be called explicitely.
  lattice=new HEM_Lattice().setWidth(10).setDepth(5);
  dynMesh.add(lattice);
  //All modifiers and subdividors are applied on a call to update()
  dynMesh.update();

  modifier=new HEM_Noise();
  modifier.setDistance(20);
  dynMesh.modify(modifier);

  render=new WB_Render(this);
}

float getDiameter() {
  angle += 0.1;
  println(sin(angle));
  return sin(angle) * 40;
}

float getNoiseLevel() {
  // Map values from  -1-1 > -80-80
  return in.right.get(0) * 1000;
}

float getW() {
  return (float) 1.0+(in.left.get(0) * 1000) *60.0/width;
}
