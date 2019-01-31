MercatorMap map;

void setup(){
  size(600, 800);
  //Intiailize your data structures early in setup 
  map = new MercatorMap(width, height, 28, 26, -81.5, -80, 0);
  loadData();
  parseData();
}

void draw(){
  background(0);
  county.draw();
}
