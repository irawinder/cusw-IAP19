/*  ORBIZER
 *  Mike and Ira Winder, 2018
 *
 *  Input / Output Functions
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

void keyPressed() {
    switch(key) {
    case 'l':
      showVertexEdges = !showVertexEdges;
      break;
    case 's':
      showReducedResolution = !showReducedResolution;
      break;
    case 'a':
      showAgents = !showAgents;
      break;
    case 'r':
      restoreDefaults();
      break;
    case 't':
      saveConfig();
      break;
    case 'y':
      loadConfig();
      break;
    case 'f':
      showFrameRate = !showFrameRate;
      break;
    case 'o':
      showAutoRotate = !showAutoRotate;
      break;
    case 'm':  //display mode toggles Projection -> Sphere -> Flat
      if(displayMode == "projection") {displayMode = "sphere";     break;}
      if(displayMode == "sphere")     {displayMode = "flat";       break;}
      if(displayMode == "flat")       {displayMode = "projection"; break;}
    case 'h':
      hide = !hide;
      break;
    case 'F':
      flipMap = !flipMap;
      break;
  }
}

void mousePressed() {
  if(displayMode == "projection") {
    w45min.listenClick();
    weq.listenClick();
    w45max.listenClick();

    translateX.listenClick();
    translateY.listenClick();
    rotate.listenClick();
    zoom.listenClick();
  }
  else if(displayMode == "sphere") {
    pitch3d.listenClick();
    rotate3d.listenClick();
    zoom3d.listenClick();
  }
  else if(displayMode == "flat") {
    s_map.listenClick();
    
    // Spawn a flight!
    PVector latlon = new PVector();
    latlon = windowXYtolatlon(mouseX, mouseY);
    spawnFlight(42.3, -71, latlon.x, latlon.y, 180, 255);
  }
}

void mouseReleased() {
  w45min.isDragged     = false;
  weq.isDragged        = false;
  w45max.isDragged     = false;

  translateX.isDragged = false;
  translateY.isDragged = false;
  rotate.isDragged     = false;
  zoom.isDragged       = false;
  
  pitch3d.isDragged    = false;
  rotate3d.isDragged   = false;
  zoom3d.isDragged     = false;
  
  s_map.isDragged      = false;
}