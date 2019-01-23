ArrayList<POI> pois;

class POI{
  //What is the coordinate of the POI in lat, lon
  PVector coord;
  float lat;
  float lon;
  

  POI(float _lat, float _lon){
    lat = _lat;
    lon = _lon;
    coord = new PVector(lat, lon);
  }
  
  void draw(){
    PVector screenLocation = map.getScreenLocation(coord);
    fill(255);
    ellipse(screenLocation.x, screenLocation.y, 10, 10);
  }
  
  
}
