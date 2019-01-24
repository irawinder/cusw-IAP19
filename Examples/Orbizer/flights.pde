import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.FileNotFoundException;
import java.nio.file.Files;

int fpMin = 1;
int fcount;
int ftime;

File flightData;
BufferedReader br;
FileReader fr;
String currentLine;

// Animated agents
ArrayList<Agent> particles;  // particles meant for testing
ArrayList<Agent> flights;    // A380 flights

//These 3 vectors could be made into a flight object of some kind ...
//
PVector fLLOrig; //Origin Lat/Lon
PVector fLLDest; //Destination Lat/Lon
PVector timeHue; //duration is x in min, takeoff time is y in min, hue is z. This is an object so functions can alter the value.

void openFlightTable() {

  flightData = new File(dataPath("a380_2 2 header ok.txt"));
  if(flightData.exists()) { 
    //I believe the following is redundent to the previous lines 
    try {
      fr = new FileReader(flightData);
    }
    catch(FileNotFoundException fnfe) { System.out.println("The specified file is not present at the given path");
    }
    
    fcount = 0;
    ftime = 0;
      
    showFlightTable2016 = true;
    
    br = new BufferedReader(fr);
      
    fLLOrig = new PVector();
    fLLDest = new PVector();
    timeHue = new PVector();
    currentLine = new String("");
    
    //All this try/catch stuff seems like garbage because I already check for this stuff.
    try {
      currentLine = br.readLine();
    }
    catch(IOException currentlineNull) {
      System.out.println("line not fount");
    }
    
    getFlightTableLine();
  }
}

void getFlightTableLine()  {
  try {
      currentLine = br.readLine();
  }
  catch(IOException currentlineNull) {
    System.out.println("line not found");
  }

  if(currentLine != null) {
    
    String[] lineData = new String[17];
    lineData = currentLine.split("\t");
      
    fLLOrig.x = Float.parseFloat(lineData[6]);
    fLLOrig.y = Float.parseFloat(lineData[7]);
    fLLDest.x = Float.parseFloat(lineData[9]);
    fLLDest.y = Float.parseFloat(lineData[10]);
    timeHue.x = Float.parseFloat(lineData[16]) - Float.parseFloat(lineData[15]);
    timeHue.y = Float.parseFloat(lineData[15]);
    timeHue.z = 0; //Read the airline and decide color. Airline is column 4
    switch(lineData[4]) {
      case "Emirates Airline":
        timeHue.z = 0;
        break;
      case "Air France":
        timeHue.z = 30;
        break;
      case "Singapore Airlines":
        timeHue.z = 60;
        break;
      case "British Airways":
        timeHue.z = 90;
        break;
      case "Lufthansa":
        timeHue.z = 120;
        break;
      case "Qatar Airways":
        timeHue.z = 150;
        break;
      default:
        timeHue.z = 200;
        break;
    }
  }
  else
  {
    //Restart the table here. This seems to work although if issues arise, they might be here.
    //This doesn't reset flights already in the air, but still looks good.
    openFlightTable();
  }
}

void checkTakeoff() {
  if(timeHue.y <= ftime) {
    spawnFlight(fLLOrig.x, fLLOrig.y, fLLDest.x, fLLDest.y, timeHue.x*fpMin, int(timeHue.z));
    getFlightTableLine();
  }
  
  fcount++;
  if(fcount >= fpMin) {
    fcount = 0;
    ftime++;
  }
}

void setupFlights() {
  flights = new ArrayList<Agent>();
}

void spawnFlight(float lat1, float lon1, float lat2, float lon2, float flightTime, int fcolor) {
  Agent f = new Agent(0,0);
  f.flightInit(lat1, lon1, lat2, lon2, flightTime, fcolor);
  flights.add(f);
}

void updateFlights() {
  if(showAgents){
    
    //This might not be the best place for this line
    if(showFlightTable2016 == true) checkTakeoff();
    
    for (int i = flights.size() - 1; i >= 0; i--) {
      Agent f = flights.get(i);
      f.update3d();
      f.drawMode();
      f.drawRoute(25);
      if(f.time > f.duration) flights.remove(i);
    }
  }
}

//
void setupParticles() {
  particles = new ArrayList<Agent>();
  for (int i=0; i<200; i++) {
    Agent a = new Agent(map.width, map.height);
    a.randomInit();
    particles.add(a);
  }
}

void updateParticles() {
  if(showAgents){
    for (Agent a: particles) {
      a.update3d();
      a.drawMode();
    }
  }
}

void copyData(File selected) throws IOException {
  //print("\n\n\n\n" + selected.getName() + "\n\n\n\n");
  if(selected.getName().equals("a380_2 2 header ok.txt")) {
  File moveMe = new File(dataPath("a380_2 2 header ok.txt"));
  Files.copy(selected.toPath(), moveMe.toPath());
  dataFound = true;
  }
  else {
    selectInput("Locate a380_2 2 header ok.txt to be copied to the data folder.", "copyData");
  }
}

String UTCFlightTime() {
  
  int minutes = ftime % 60;
  int hours = ftime / 60 % 24;
  int days = (ftime / (24 * 60) + 1);
  
  String UTCstr = new String(days + "/1/2016  " + hours + ":" + minutes);
  
  return UTCstr;
}