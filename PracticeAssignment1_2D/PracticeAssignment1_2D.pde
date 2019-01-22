ArrayList<Building> buildings;
HScrollbar slider;
int minSize; 

void setup(){
  size(600,600);
  noStroke();
  smooth();
  slider = new HScrollbar(20, 50, 200, 16, 16);
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

void drawBuildings(){
    for (int i = 0; i < numBuildings; i++){
    buildings.get(i).display();
  }
}

void createBuildings(){
  buildings = new ArrayList();
  for (int i = 0; i < numBuildings; i++){
    PVector location = new PVector(random(0, width), random(0, height));
    buildings.add(new Building(location, i, buildings));
  }
  
  for (int i = 0; i < numBuildings; i++){
    buildings.get(i).collide();
  }
}
