/*  ORBIZER
 *  Mike and Ira Winder, 2018
 *
 *  Init Functions
 *
 *  MIT LICENSE:  Copyright 2018 Mike and Ira Winder
 *
 *               Permission is hereby granted, free of charge, to any person obtaining a copy of this software 
 *               and associated documentation files (the "Software"), to deal in the Software without restriction, 
 *               including without limitation the rights to use, copy, modify, merge, publish, distribute, 
 *               sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is 
 *               furnished to do so, subject to the following conditions:
 *
 *               The above copyright notice and this permission notice shall be included in all copies or 
 *               substantial portions of the Software.
 *
 *               THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT 
 *               NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
 *               NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, 
 *               DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
 *               OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
 
String version = "v0.9.2";

String label = "Orbizer | Spherical Projection Mapping, " + version + "\n" +
               "Mike and Ira Winder\noncue.design"; 

// Graphics Objects
PImage map;
PImage[] maps;
PGraphics canvas;

// Display Mode Setting
String displayMode;

// Map Setting
int mapIndex;
String[] mapFile = { // Names of map files in /data folder
  "world.topo.bathy.200407.3x5400x2700.jpg",
  "Equirectangular_projection_crop.png",
  "BlankMap-Equirectangular.png",
  "BlankMap-Equirectangular_night.png",
  "Earth_night_homemade.jpg"
};

boolean showVertexEdges;
boolean showReducedResolution;
boolean showFrameRate;
boolean showAutoRotate;
boolean showAgents;
boolean showFlightTable2016;
boolean dataFound;

float rotationFloat;

boolean hide = false;
 
int phaseCounter = 0;
String[] phase = {
  "Initializing Maps",
  "Loading Flight Data",
  "Setting up Map Projections"
};
int DELAY = 500;

// loads setup() information in phases so that loading progress can be shown
//
void init() {
  
  if (phaseCounter == 0) {
    
    //Locate data Prompt
    dataFound = false;
    File filetest = new File(dataPath("a380_2 2 header ok.txt"));
    if(filetest.exists()) { 
      dataFound = true;
    }
    else {
      selectInput("Locate a380_2 2 header ok.txt to be copied to the data folder.", "copyData");
    }
    
    //Stall out program until copyData resolves
    while(!dataFound){
      print("Waiting on Data Selection. data found: " + dataFound + "\n");
      delay(1000);
    }
    
    // Load all the images into the program 
    //
    maps = new PImage[mapFile.length];
    for (int i=0; i<maps.length; i++) {
      maps[i] = loadImage(mapFile[i]);
    }
      
    // Select the image to display in the program 
    //
    mapIndex = 0;
    map = maps[mapIndex];
    
    canvas = createGraphics(map.width, map.height, P3D);
  
  } else if (phaseCounter == 1) {
    
    showAutoRotate = true;
    displayMode    = "flat";
    showAgents     = true;
    
    processAirportData();
    processRouteData();
    
    // Set up particles in random spherical orbits
    //
    setupParticles();
    
    // Set up A380 Flight Agents
    //
    setupFlights();
    
    // Opens data file that flights are read from 
    //
    openFlightTable();
    
  } else if (phaseCounter == 2) {
  
    setupFlat();
    setupProjection();
    setupSphere();
    
    // Restore Default Slider and Key Commands
    //
    restoreDefaults();
    
    initialized = true;
  }
  
  loadingScreen(loadingBG, phaseCounter+1, phase.length, phase[phaseCounter]);
  phaseCounter++;
  delay(DELAY);
}

void restoreDefaults(){
  defaultFlat();
  defaultProjection();
  defaultSphere();
  rotationFloat = 0;
  showVertexEdges = false;
  showReducedResolution = false;
}
