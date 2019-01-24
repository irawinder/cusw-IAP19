controlSlider pitch3d;
controlSlider rotate3d;
controlSlider zoom3d;

void setupSphere(){
  
  int xOffset = 50;
  int vOffset = 337;
  int vGap = 70;
  int sWidth = int(0.3*(width - height));
  
  zoom3d = new controlSlider();
  zoom3d.name = "Scale %";
  //zoom3d.keyPlus = 'w';
  //zoom3d.keyMinus = 'q';
  zoom3d.len = sWidth;
  zoom3d.xpos = xOffset;
  zoom3d.ypos = vOffset;
  zoom3d.valMin = 0;
  zoom3d.valMax = 500;
  zoom3d.value = 0.3*height;
  
  vOffset += vGap;
  pitch3d = new controlSlider();
  pitch3d.name = "Pitch";
  //pitch3d.keyPlus = 'w';
  //pitch3d.keyMinus = 'q';
  pitch3d.len = sWidth;
  pitch3d.xpos = xOffset;
  pitch3d.ypos = vOffset;
  pitch3d.valMin = -90;
  pitch3d.valMax = 90;
  pitch3d.value = 45;
  
  vOffset += vGap;
  rotate3d = new controlSlider();
  rotate3d.name = "Rotate";
  //rotate3d.keyPlus = 'w';
  //rotate3d.keyMinus = 'q';
  rotate3d.len = sWidth;
  rotate3d.xpos = xOffset;
  rotate3d.ypos = vOffset;
  rotate3d.valMin = 0;
  rotate3d.valMax = 360;
  rotate3d.value = 180;
}


void displaySphere() {
  
  drawSphere(30,60);
  if (!hide) drawSphereControls();
  
}

void drawSphereControls() {
  // Command to help you draw 2D UI graphics over 3D objects
  // This are computationally intense so use sparingly!
  hint(DISABLE_DEPTH_TEST);
  
  String frameRt = "";
  if (showFrameRate) frameRt = "\n\nFramerate: " + frameRate;
  
  fill(255); textAlign(LEFT, TOP);
  
  text("Press ' m ' to toggle display Mode\n" +
       "Press ' f ' to show or hide framerate\n" + 
       "Press ' s ' to reduce or increase resolution\n" +
       "Press ' o ' to enable AutoRotation\n" +
       "Press ' r ' to reset callibration\n" +
       "Press ' a ' to show or hide agents\n" +
       "Press ' t ' to save configuration\n" +
       "Press ' y ' to load last saved configuration\n" +
       "Press ' h ' to hide controls" +
       "\nFlightTime: UTC " +  UTCFlightTime() +
       
       frameRt, 37, 110);
  
  pitch3d.listen();
  pitch3d.drawMe();
  
  zoom3d.listen();
  zoom3d.drawMe();
  
  rotate3d.listen();
  rotate3d.drawMe();
  
  hint(ENABLE_DEPTH_TEST);
}

void drawSphere(int segLat, int segLon) {
  
  
  noStroke();
  
  //Extra control options 
  if (showReducedResolution) {
    segLat = 8; 
    segLon = 16;
  }
  
  if (showAutoRotate) {
    rotate3d.value += 0.1;
    if(rotate3d.value >= 360) rotate3d.value = 0;
  }

  float segAng = 180/segLat;

  pushMatrix();
  translate(width/2,height/2,0);
  scale(zoom3d.value);
  
  rotateX(-pitch3d.value*PI/180);
  rotateY(rotate3d.value*PI/180);
  
  for(int i=0; i<segLat;i++) {
    drawRing(i*segAng-90,(i+1)*segAng-90, segLon);
  }
  popMatrix();
}

void drawRing(float botPhi,float topPhi, int segments) {
  
  //This maybe saves some cpu math
  float segAng = 2*PI/segments;
  float botRad = botPhi*PI/180;
  float topRad = topPhi*PI/180;
  
  //noStroke();
  
  beginShape(TRIANGLE_STRIP);
  texture(canvas);

  for(int i=0; i<=(segments);i++) {
    vertex(getX3D(botRad,  i*segAng), -sin(botRad), getZ3D(botPhi*PI/180,  i*segAng), i*map.width/segments, map.height*(1-(botPhi+90)/180));
    vertex(getX3D(topRad,  i*segAng), -sin(topRad), getZ3D(topPhi*PI/180,  i*segAng), i*map.width/segments, map.height*(1-(topPhi+90)/180));
  }
  endShape();
}

float getX3D(float phi, float theta){
  float x = sin(theta)*cos(phi);
  return x;
}

float getZ3D(float phi, float theta){
  float z = cos(theta)*cos(phi);
  return z;
}

void defaultSphere() {
  zoom3d.value = 0.3*height;
  pitch3d.value = 45;
  rotate3d.value = 180;
}