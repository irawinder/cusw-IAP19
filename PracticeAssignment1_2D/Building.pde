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
  
  Building(PVector center_in, int id_in, ArrayList<Building> others_in){
    center = center_in;
    id = id_in;
    others = others_in;
    buildingWidth = random(minSize, minSize+20);
    buildingHeight = random(minSize, minSize+20);
  } 
  
  void collide(){
    for (int i = id + 1; i < numBuildings; i++){
      float distance = dist(center.x, center.y, others.get(i).center.x, others.get(i).center.y);
      float minDist = buildingWidth + others.get(i).buildingWidth + 5;
      float minDistH = others.get(i).buildingHeight/2 + buildingHeight + 10;
      if (distance < minDist && distance < minDistH){
        display = false;
        break;
      }
    }
  }
  
  void display(){
    if (!display) return;
    stroke(255);
    fill(200);
    rectMode(CENTER);
    rect(center.x, center.y, buildingWidth, buildingHeight);
  }
}
