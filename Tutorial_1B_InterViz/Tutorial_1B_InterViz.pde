/* My First Processing Script */

// Width of an Object, in pixels
int SCALE = 40;

ArrayList<Building> city;

void setup(){
  size(1200, 800);
  //fullScreen();
  
  city = new ArrayList<Building>();
  
  // Calculate the Dimensions of my Grid
  int numWide = width / SCALE;
  int numHigh = height / SCALE;
  
  for(int i=0; i<numWide; i++) {
    for(int j=0; j<numHigh; j++) {
      
      //Initialize building variables
      float x_temp = 0.5*SCALE + i*SCALE;
      float y_temp = 0.5*SCALE + j*SCALE;
      float base = random(0.1*SCALE, 0.5*SCALE);
      
      color new_color;
      colorMode(HSB);
      new_color = color( random(255.0), 255, 255);
      
      Building b = new Building(x_temp, y_temp, base, new_color);
      city.add(b);
    }
  }
}

void draw(){
  background(0);
  
  for(Building b: city) {
    b.update();
    b.display2D();
  }
}
