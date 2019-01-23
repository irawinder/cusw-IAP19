//First make a blank map 
MercatorMap map;
PImage background;

void setup(){
  size(1000, 650);
  map = new MercatorMap(width, height, 42.3636, 42.3557, -71.1034, -71.0869, 0);
  polygons = new ArrayList<Polygon>();
  
  //Handle data
  loadData();
  parseData();
}

void draw(){

  image(background, 0, 0);
  
}
