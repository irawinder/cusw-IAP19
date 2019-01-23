JSONObject example;
JSONArray features;
//Look at https://processing.org/reference/JSONObject.html for more info

void loadData(){
  background = loadImage("data/background.png");
  background.resize(width, height);
  
  example = loadJSONObject("data/example.json");
  features = example.getJSONArray("features");
  
  println("There are : ", features.size(), " features.");
  
}

void parseData(){
  //First do simple object
  JSONObject feature = features.getJSONObject(0);
  println(feature.getJSONObject("geometry"));

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
      //create new Polygon
    }
    
    if(type.equals("LineString")){
      //create new Way
    }
    
  }
}
