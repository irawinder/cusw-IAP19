JSONObject example;
JSONArray features;
JSONObject wholeArea;
//Look at https://processing.org/reference/JSONObject.html for more info

void loadData(){
  background = loadImage("data/background.png");
  background.resize(width, height);
  
  //Small example area
  example = loadJSONObject("data/example.json");
  features = wholeArea.getJSONArray("features");
  
  //Whole Area
  //wholeArea = loadJSONObject("data/wholeArea.json");
  //features = example.getJSONArray("features");
  
  println("There are : ", features.size(), " features."); 
}

void parseData(){
  //First do simple object
  JSONObject feature = features.getJSONObject(0);

  //Sort 3 types into our respective classes to draw
  for(int i = 0; i< features.size(); i++){
    String type = features.getJSONObject(i).getJSONObject("geometry").getString("type");
    JSONObject geometry = features.getJSONObject(i).getJSONObject("geometry");
    JSONObject properties =  features.getJSONObject(i).getJSONObject("properties");
    
    if(type.equals("Point")){
      //create new POI
      float lat = geometry.getJSONArray("coordinates").getFloat(1);
      float lon = geometry.getJSONArray("coordinates").getFloat(0);
      POI poi = new POI(lat, lon);
      pois.add(poi);
    }
    
    if(type.equals("Polygon")){
      ArrayList<PVector> coords = new ArrayList<PVector>();
      JSONArray coordinates = geometry.getJSONArray("coordinates").getJSONArray(0);
      for(int j = 0; j<coordinates.size(); j++){
        float lat = coordinates.getJSONArray(j).getFloat(1);
        float lon = coordinates.getJSONArray(j).getFloat(0);

        PVector coordinate = new PVector(lat, lon);
        coords.add(coordinate);
      }
      
      Polygon poly = new Polygon(coords);
      polygons.add(poly);
    }
    
    if(type.equals("LineString")){
      ArrayList<PVector> coords = new ArrayList<PVector>();
      println(geometry);
      JSONArray coordinates = geometry.getJSONArray("coordinates");
      for(int j = 0; j<coordinates.size(); j++){
        float lat = coordinates.getJSONArray(j).getFloat(1);
        float lon = coordinates.getJSONArray(j).getFloat(0);

        PVector coordinate = new PVector(lat, lon);
        coords.add(coordinate);
      }
      
      Way way = new Way(coords);
      ways.add(way);
      
    }
    
  }
}
