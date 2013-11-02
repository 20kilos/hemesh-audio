import wblut.math.*;
import wblut.processing.*;
import wblut.core.*;
import wblut.hemesh.*;
import wblut.geom.*;
import ddf.minim.analysis.*; //imports the correct library
import ddf.minim.*;

Minim       minim;
AudioInput in;       // this calls your laptops audio in mic

HE_Mesh mesh, copymesh;
WB_Render render;

void setup() {
  size(800, 800, P3D);
  createMesh();
  
  minim = new Minim(this);
  in = minim.getLineIn();
  
  HEM_Noise modifier=new HEM_Noise();
  modifier.setDistance(20);
  copymesh.modify(modifier);

  render=new WB_Render(this);
}

void draw() {
  background(120);
  directionalLight(255, 255, 255, 1, 1, -1);
  directionalLight(127, 127, 127, -1, -1, 1);
  translate(400,400, 0);
  rotateY(mouseX*1.0f/width*TWO_PI);
  HEM_Noise modifier=new HEM_Noise();
  copymesh=mesh.get();
  modifier.setDistance(in.left.get(0) * 1028/20);
  copymesh.modify(modifier);
  
  rotateX(mouseY*1.0f/height*TWO_PI);
  fill(255);
  noStroke();
  render.drawFaces(copymesh);
  stroke(0);
  render.drawEdges(mesh);
}


void createMesh(){
  HEC_Cube creator=new HEC_Cube(300,5,5,5);
  mesh=new HE_Mesh(creator); 
  copymesh=mesh.get();
}
