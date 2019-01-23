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
    println(features.getJSONObject(i).getJSONObject("geometry").getString("type"));
    String type = features.getJSONObject(i).getJSONObject("geometry").getString("type");
    if(type.equals("Point")){
      //create new POI
    }
    if(type.equals("LineString")){
      //create new Way
    }
    if(type.equals("Polygon")){
      //create new Polygon
    }
  }
}
