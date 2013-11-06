import wblut.math.*;
import wblut.processing.*;
import wblut.core.*;
import wblut.hemesh.*;
import wblut.geom.*;

class Mesh 
{
  private HE_Mesh mesh;
  private HE_DynamicMesh dynMesh;
  
  private HEM_Noise noiseModifier;
  private WB_Render render;
  private HEM_Lattice lattice;
  
  Mesh(PApplet p, int sUFacets, int sVFacets, 
          int latticeW, int latticeDepth)
  {
    HEC_Sphere creator = new HEC_Sphere();
    creator.setRadius(150); 
    creator.setUFacets(sUFacets);
    creator.setVFacets(sVFacets);
    
    mesh = new HE_Mesh(creator); 
    dynMesh = new HE_DynamicMesh(mesh);
    dynMesh.add(new HEM_Extrude().setDistance(20));
  
    lattice = new HEM_Lattice();
    lattice.setWidth(latticeW);
    lattice.setDepth(latticeDepth);
    dynMesh.add(lattice);
   
    noiseModifier = new HEM_Noise();
    dynMesh.modify(lattice);
    dynMesh.update();
    render = new WB_Render(p);
  }
  
  public void drawMesh(float noiseDistance)
  {
    pushMatrix();
    translate(width/2, height/2);
    rotate();
    lattice.setWidth(30).setDepth(5);
    dynMesh.update();
    noiseModifier.setDistance(noiseDistance);
    dynMesh.modify(noiseModifier);
    fill(143, 60, 70, 60);
    stroke(0);
    render.drawFaces(dynMesh);
    popMatrix();
  }
}
