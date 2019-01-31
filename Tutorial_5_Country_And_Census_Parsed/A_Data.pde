Table CountyBoundary;
Table CensusData;
Table CensusBlocks;


void loadData(){
  CountyBoundary = loadTable("data/FloridaNodes.csv", "header");
  //CensusData = loadTable("
}

void parseData(){
  //First parse county polygon
    ArrayList<PVector> coords = new ArrayList<PVector>();
    for(int i = 0; i<CountyBoundary.getRowCount(); i++){
         float lat = float(CountyBoundary.getString(i, 2));
         float lon = float(CountyBoundary.getString(i, 1));
         coords.add(new PVector(lat, lon));
    }
     county = new Polygon(coords);

  //Test case for point in Polygon
  //println(county.pointInPolygon(new PVector(27.25, -80.85)));
}
