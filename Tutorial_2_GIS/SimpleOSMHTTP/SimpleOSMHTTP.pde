import http.requests.*;
void setup(){  
  size(400,400);
  smooth();
  
  GetRequest get = new GetRequest("http://api.openstreetmap.org/api/0.6/map?bbox=-71.06528,42.354065,-71.05776,42.360153");
  get.send(); // program will wait untill the request is completed
  
  String output = get.getContent();
  String[] test = split(output, "fhajksdhfjajksdkfoiijhedjifkm"); //just gets into a text array without splitting because that char string won't exist
  saveStrings( "exports/" + "OSM" + ".xml", test);

}
