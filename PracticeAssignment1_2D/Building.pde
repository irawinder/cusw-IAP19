/*
For the most part, this class allows us to make mostly non overlapping "buildings"
*/
int numBuildings = 100;
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
    buildingWidth = random(30, 60);
    buildingHeight = random(30, 70);
  } 
  
  void collide(){
    for (int i = id + 1; i < numBuildings; i++){
      float distance = dist(center.x, center.y, others.get(i).center.x, others.get(i).center.y);
      float minDist = others.get(i).buildingWidth/2 + buildingWidth + 10;
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
    fill(random(200));
    rectMode(CENTER);
    rect(center.x, center.y, buildingWidth, buildingHeight);
  }
}
