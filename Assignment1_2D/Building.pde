/*
For the most part, this class allows us to make mostly non overlapping "buildings"
*/
int numBuildings = 0;
boolean overlap;

class Building{
  float buildingWidth, buildingHeight;
  PVector center; 
  int id;
  ArrayList<Building> others;
  boolean display = true;
  
  //Constructor with the relevant building information
  Building(PVector center_in, int id_in, ArrayList<Building> others_in){
    center = center_in;
    id = id_in;
    others = others_in;
    buildingWidth = random(minSize, minSize+20);
    buildingHeight = random(minSize, minSize+20);
  } 
  
  void collide(){
    //Checks if two rectangles collide by confirming the distance between
    for (int i = id + 1; i < numBuildings; i++){
      float distance = dist(center.x, center.y, others.get(i).center.x, others.get(i).center.y);
      float minDist = buildingWidth + others.get(i).buildingWidth + 5;
      float minDistH = others.get(i).buildingHeight/2 + buildingHeight + 10;
      if (distance < minDist && distance < minDistH){
        //if they're too close, they collide, therefore don't display
        display = false;
        break;
      }
    }
  }
  
  void display(){
    //If you display, draw the rectangle
    if (!display) return;
    stroke(255);
    fill(map(buildingWidth*buildingHeight, 30*30, 100*100, 0, 230));
    rectMode(CENTER);
    rect(center.x, center.y, buildingWidth, buildingHeight);
  }
}
