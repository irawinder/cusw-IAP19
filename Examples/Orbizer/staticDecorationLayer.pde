import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.FileNotFoundException;

//Much of this code relies on the file IO from flights.pde so be careful

Table cities;
Table routes;

void processAirportData() {
  
  cities = new Table();
  
  cities.addColumn("lat");
  cities.addColumn("lon");
  cities.addColumn("flights");
  
  TableRow newRow = cities.addRow();
  
  openFlightTable();
  
  try {
    currentLine = br.readLine();
  }
  catch(IOException currentlineNull) {
    System.out.println("line not found");
    currentLine = null;
  }

  while(currentLine != null) {
    
    String[] lineData = new String[17];
    lineData = currentLine.split("\t");
      
    fLLOrig.x = Float.parseFloat(lineData[6]);
    fLLOrig.y = Float.parseFloat(lineData[7]);
    fLLDest.x = Float.parseFloat(lineData[9]);
    fLLDest.y = Float.parseFloat(lineData[10]);
    timeHue.x = Float.parseFloat(lineData[16]) - Float.parseFloat(lineData[15]);
    timeHue.y = Float.parseFloat(lineData[15]);
    timeHue.z = 0; //Read the airline and decide color. Airline is column 4
    
    checkLLforCities(fLLOrig);
    checkLLforCities(fLLDest);
    
    //Read the next line at end of checking step then repeat
    try {
      currentLine = br.readLine();
    }
    catch(IOException currentlineNull) {
      System.out.println("line not found");
      currentLine = null;
    }
  }
  //saveTable(cities, "data/cities.csv");
}

void checkLLforCities(PVector LL) {
  boolean matched = false;
  for (TableRow row : cities.rows()) {
    if((LL.x == row.getFloat("lat")) && (LL.y == row.getFloat("lon"))) {
      int tempCount = row.getInt("flights");
      row.setInt("flights", tempCount+1);
      matched = true;
    }
  }
  if(!matched) {
    TableRow newRow = cities.addRow();
    newRow.setFloat("lat", LL.x);
    newRow.setFloat("lon", LL.y);
    newRow.setInt("flights", 1);
  }
}

void processRouteData() {  
  routes = new Table();
  
  routes.addColumn("lat1");
  routes.addColumn("lon1");
  routes.addColumn("lat2");
  routes.addColumn("lon2");
  routes.addColumn("flights");
  
  TableRow newRow = routes.addRow();
  openFlightTable();
  
  try {
    currentLine = br.readLine();
  }
  catch(IOException currentlineNull) {
    System.out.println("line not found");
    currentLine = null;
  }

  while(currentLine != null) {
    
    String[] lineData = new String[17];
    lineData = currentLine.split("\t");
      
    fLLOrig.x = Float.parseFloat(lineData[6]);
    fLLOrig.y = Float.parseFloat(lineData[7]);
    fLLDest.x = Float.parseFloat(lineData[9]);
    fLLDest.y = Float.parseFloat(lineData[10]);
    timeHue.x = Float.parseFloat(lineData[16]) - Float.parseFloat(lineData[15]);
    timeHue.y = Float.parseFloat(lineData[15]);
    timeHue.z = 0; //Read the airline and decide color. Airline is column 4
    
    checkLLforRoutes(fLLOrig, fLLDest);
    
    //Read the next line at end of checking step then repeat
    try {
      currentLine = br.readLine();
    }
    catch(IOException currentlineNull) {
      System.out.println("line not found");
      currentLine = null;
    }
  }
  //saveTable(routes, "data/routes.csv");
}

void checkLLforRoutes(PVector LL1, PVector LL2) {
  boolean matched = false;
  //I have to check thr route forward and back so I don't count it as two routes
  for (TableRow row : routes.rows()) {
    if(  (LL1.x == row.getFloat("lat1")) && (LL1.y == row.getFloat("lon1")) && (LL2.x == row.getFloat("lat2")) && (LL2.y == row.getFloat("lon2")) ) {
      int tempCount = row.getInt("flights");
      row.setInt("flights", tempCount+1);
      matched = true;
    }
    else if( (LL1.x == row.getFloat("lat2")) && (LL1.y == row.getFloat("lon2")) && (LL2.x == row.getFloat("lat1")) && (LL2.y == row.getFloat("lon1")) ) {
      int tempCount = row.getInt("flights");
      row.setInt("flights", tempCount+1);
      matched = true;
    }
  }
  if(!matched) {
    TableRow newRow = routes.addRow();
    newRow.setFloat("lat1", LL1.x);
    newRow.setFloat("lon1", LL1.y);
    newRow.setFloat("lat2", LL2.x);
    newRow.setFloat("lon2", LL2.y);
    newRow.setInt("flights", 1);
    print("found a new airport \n ");
  }
}

void drawCitiesCanvas() {
  int rsize = 10;
  for (TableRow row : cities.rows()) {
    PVector tempLL = new PVector();
    PVector tempXY = new PVector();
    tempLL.x = row.getFloat("lat");
    tempLL.y = row.getFloat("lon");
    tempXY = latlontoCanvasXY(tempLL);
    canvas.fill(255, 50); canvas.stroke(255); canvas.strokeWeight(1);
    canvas.rect(tempXY.x-rsize/2, tempXY.y-rsize/2,rsize, rsize);
  }
}

void drawRoutesCanvas() {
 // drawLine(float lat1, float lon1,float lat2, float lon2, int segments) {
  for (TableRow row : routes.rows()) {
    //stroke(255,255,255, int(float(row.getInt("flights"))/50.0*255.00));
    stroke(0,0,0, 0);
    drawLine(row.getFloat("lat1"),row.getFloat("lon1"),row.getFloat("lat2"),row.getFloat("lon2"), 20);
  }
}
    
    
    
    
    