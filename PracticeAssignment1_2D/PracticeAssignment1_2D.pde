ArrayList<Building> buildings = new ArrayList();
void setup(){
  size(500,500);
  noStroke();
  smooth();
  for (int i = 0; i < numBuildings; i++){
    PVector location = new PVector(random(0, width), random(0, height));
    buildings.add(new Building(location, i, buildings));
  }
  
      for (int i = 0; i < numBuildings; i++){
    buildings.get(i).collide();
  }
  drawBuildings();
}

void draw(){
}

void drawBuildings(){
   background(255);
    for (int i = 0; i < numBuildings; i++){
    buildings.get(i).display();
  }
}
