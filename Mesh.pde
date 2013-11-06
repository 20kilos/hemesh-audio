import wblut.math.*;
import wblut.processing.*;
import wblut.core.*;
import wblut.hemesh.*;
import wblut.geom.*;

class Mesh 
{
  HE_Mesh mesh;
  HE_DynamicMesh dynMesh;
  
  HEM_Noise noiseModifier;
  WB_Render render;
  HEM_Lattice lattice;
  
  Mesh(PApplet p)
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
    render = new WB_Render(p);
  }
  
  void drawMesh()
  {
    lattice.setWidth(30).setDepth(5);
    dynMesh.update();
    noiseModifier.setDistance(tapeDeck.getAmplitude());
    dynMesh.modify(noiseModifier);
    fill(143, 60, 70, 60);
    stroke(0);
    render.drawFaces(dynMesh);
  }
}
