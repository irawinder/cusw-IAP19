MercatorMap map;

void setup(){
  CensusPolygons = new ArrayList<Polygon>();
  size(600, 800);
  //Intiailize your data structures early in setup 
  map = new MercatorMap(width, height, 29, 26, -81.5, -80, 0);
  loadData();
  parseData();
}

void draw(){
  background(0);
  
  for(int i = 0; i<CensusPolygons.size(); i++){
    CensusPolygons.get(i).draw();
  }
  
  county.draw();
  
}
