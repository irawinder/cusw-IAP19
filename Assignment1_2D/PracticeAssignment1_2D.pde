ArrayList<Building> buildings;
HScrollbar slider;
int minSize;

/*
This script shows a simple city drawing where 
the building sizes change based on a slider

Nina Lutz
IAP Comp Urban Science Workshop 2019 
*/

void setup(){
  //Code here only runs once
  size(600,600);
  noStroke();
  smooth();
  //Make a new slider
  slider = new HScrollbar(20, 50, 200, 16, 16);
  //set some parameters
  numBuildings = 100;
  minSize = int(map(int(slider.getPos()), 22, 220, 30, 100));
  createBuildings();
}

void draw(){
  background(255);
  drawBuildings();
  fill(0);
  text("Building Size", 20, 25);
  slider.update();
  slider.display();
  if(minSize != int(map(int(slider.getPos()), 22, 220, 30, 100))){
    minSize = int(map(int(slider.getPos()), 22, 220, 30, 100));
    createBuildings();
    println(int(slider.getPos()));
  }
}

//draws the buildings
void drawBuildings(){
    for (int i = 0; i < numBuildings; i++){
    buildings.get(i).display();
  }
}

void createBuildings(){
  //create buildings using elements and functions from building class
  buildings = new ArrayList();
  
  //make buildings
  for (int i = 0; i < numBuildings; i++){
    PVector location = new PVector(random(0, width), random(0, height));
    buildings.add(new Building(location, i, buildings));
  }
  
  //check for overlaps
  for (int i = 0; i < numBuildings; i++){
    buildings.get(i).collide();
  }
}
