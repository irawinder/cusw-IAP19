/*  ORBIZER
 *  Mike and Ira Winder, 2018
 *
 *  Orbizer transforms animated latitutue and longitude date into different projection systems including:
 *  (1) Equirectangular (2) Radial-Flat and (3) Spherical
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
 
boolean initialized;

// setup() executes once when application begins (this is a default Processing method)
// 
void setup() {
  size(1280, 800, P3D);
  //fullScreen(P3D);
  
  initialized = false;
  loadingBG = loadImage("loading.jpg");
  
  loadingScreen(loadingBG, phaseCounter+1, phase.length, phase[phaseCounter]);
}

// draw() repeats on infinite loop after setup (this is a default Processing method)
// 
void draw() {
  
  if (!initialized) {
    
    // A_Init.pde - runs until initialized = true
    // 
    init();
    
    
  } else {
    
    // Run reoccuring computation and draw functions
    // 
    run();
  }
  
}

void run() {
  background(0); // Draw black pixels as background every frame
  
  // "PGraphics canvas" is the 2D Equirectangular map that we transform into radial and spherical forms
  //
  canvas.beginDraw();
  canvas.background(0);
  
  // "PImage map" is file we use as the globe's background (i.e. false color of continents and oceans)
  //
  canvas.image(map, 0, 0);
  
  // Draw known origin and destination points to canvas
  //
  drawCitiesCanvas();
  
  // Update and draw A380 Flight Agents
  //
  updateFlights();
  
  // Random spherical particals
  //
  //updateParticles();
  
  // These lines test geodesic "great circle" lines connecting known places
  //
  boolean debugLines = false;
  if (debugLines) {
    drawLine( 42.3,  -71.0,  43.6,    1.4, 10);   // Boston to Toulouse
    drawLine( 35.7,  139.7,  34.1, -118.0, 10);   // Tokyo to LA
    drawLine( 47.6, -122.3,  55.8,   37.1, 30);   // Seattle to Moscow
    drawLine( 28.7,   77.1, -33.9,   18.4, 20);   // Dehli to Cape Town
    drawLine(-51.8,  -59.5, -33.9,  151.2, 20);   // Falkland Islands to Sydney
    drawLine(-33.9,  151.2, -51.8,  -59.5, 20);   // Sydney to Falkland Islands
    
    //Boston to Mouse Position
    //
    if(displayMode == "flat") {
      float mouseLat = (float(height-mouseY)/height*180- 90);
      float mouseLon = (float(       mouseX)/width *360-180);
      drawLine(42.3, -71, mouseLat, mouseLon, 40);  
    }
  }
  
  canvas.endDraw();
  
  switch(displayMode) {
    
    case "projection":
      displayProjection();
      break;
    case "sphere":
      displaySphere();
      break;
    case "flat":
      displayFlat();
      break;
      
  }
  
  hint(DISABLE_DEPTH_TEST);
  fill(255); textAlign(LEFT, TOP);
  if (!hide) text(label,37,37);
  hint(ENABLE_DEPTH_TEST);
}
