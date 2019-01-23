class Agent {
  PVector location, alatlon, llOrig, llDest;
  int w, h;
  float hue;
  
  float bearing, speed, time, duration;
  boolean willEnd;
  
  Agent(int w, int h) {
    this.w = w;
    this.h = h;
    location = new PVector(0,0);
    alatlon = new PVector(0,0);
    llOrig = new PVector(0,0);
    llDest = new PVector(0,0);
    bearing = 90;
    speed = 0;
    hue = 0;
    duration = 0; //Duration will be measured in frames, with a possible timescale option later
    willEnd = false;
  }
  
  void randomInit() {
    //sphere agents
    float randomLat = random(-90, 90);
    float randomLon = random(-180, 180);
    alatlon = new PVector(randomLat, randomLon);
    bearing = random(0,360); //Azimuth in degrees as a compass
    speed = random(0.1,0.5); //speed in degrees per second

    willEnd = false;
    hue = random(0, 255);
    
    location = latlontoCanvasXY(alatlon);
  }
  
  void flightInit(float lat1, float lon1, float lat2, float lon2, float flightTime, int fhue) {
    alatlon = new PVector(lat1, lon1);
    llOrig = new PVector(lat1, lon1);
    llDest = new PVector(lat2, lon2);
    bearing = calcBearing(lat1, lon1, lat2, lon2);
    speed = calcAngDist(lat1, lon1, lat2, lon2)/flightTime;
    duration = flightTime;
    time = 0;

    willEnd = true;
    hue = fhue;
    
    location = latlontoCanvasXY(alatlon);
  }

  void update3d() {
    float c = PI/180;
    float newBearing = 0;
    
    float lat1, lon1, lat2, lon2;
    
    lat1 = alatlon.x*c;
    lon1 = alatlon.y*c;
    lat2 = asin( sin(lat1)*cos(speed*c) + cos(lat1)*sin(speed*c)*cos(bearing*c) );
    lon2 = lon1 + atan2( sin(bearing*c)*sin(speed*c)*cos(lat1), cos(speed*c)-sin(lat1)*sin(lat2) );
    
    newBearing = atan2( sin(lon1-lon2) * cos(lat1),  cos(lat2)*sin(lat1) - sin(lat2)*cos(lat1)*cos(lon1-lon2))/c;
    
    bearing = (newBearing + 180.0) % 360.0;
    
    alatlon.x = lat2/c;
    alatlon.y = lon2/c;
    
    if(alatlon.y > 180.0) alatlon.y -= 360;
    else if(alatlon.y < -180.0) alatlon.y += 360;
    
    if(willEnd) {
      time++;
    }

    location = latlontoCanvasXY(alatlon);
  }

  void drawSimple() {
     canvas.fill(hue, 255, 255);
     canvas.noStroke();
     canvas.ellipse(location.x, location.y, 5, 5);
  }
  
  void drawMode() {
    canvas.colorMode(HSB);
    canvas.fill(hue, 255, 255, 100);
    canvas.colorMode(RGB);
    canvas.stroke(255, 200);
    canvas.strokeWeight(1);
    int diameter = 6;
    switch(displayMode) {
      case "projection":
        canvas.ellipse(location.x, location.y, diameter, diameter);
        break;
      case "sphere":
        // Need to draw "wide" agents near northern-most and southern-most latitudes
        float distortion = sqrt(tan((location.y/canvas.height-0.5)*PI)*tan((location.y/canvas.height-0.5)*PI)+1);
        canvas.ellipse(location.x, location.y, distortion*diameter, diameter);
        break;
      case "flat":
        canvas.ellipse(location.x, location.y, diameter, diameter);
        break;
    }
  }
  
  void drawRoute(int segments) {
    // dynamic alpha to fade route line in and out during take off and landing
    float alpha = 50.0 * (1 - abs(time - 0.5*duration)/(0.5*duration) ); 
    canvas.colorMode(HSB);
    canvas.stroke(hue, 255, 255, alpha);
    canvas.colorMode(RGB);
    canvas.strokeWeight(4);
    drawLine(llOrig.x, llOrig.y,llDest.x,llDest.y, segments);
  }
}