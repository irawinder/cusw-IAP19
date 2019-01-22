/* Tuturial 1A
   Simple demonstration of drawing and interacting with 
   a grid of visual objects in Processing.
 */

// Width of an object, in pixels
int SCALE = 40;

// List of building objects in our city
ArrayList<Building> city;

// true / false variable that determines which camera angle to show
boolean perspective = false;

void setup() {
  
  // sets canvas window to 1200 x 800 pixels
  size(1200, 800, P3D);
  
  // Calculate the dimensions of the grid
  int numWide = width  / SCALE;
  int numHigh = height / SCALE;
  
  // Allocate memory for our building objects
  city = new ArrayList<Building>();
  
  // Loop through every grid cell in our city, i x j
  for (int i=0; i<numWide; i++) {
    for (int j=0; j<numHigh; j++) {
      
      // Initalize with Grid Location and Random Size
      float x_temp = 0.5*SCALE + i*SCALE;
      float y_temp = 0.5*SCALE + j*SCALE;
      float base = random(5.0, 0.5*SCALE);
      float tall = random(0.1*SCALE, 0.5*SCALE);
      
      // Random Color
      colorMode(HSB); // (Hue, Saturation, Brightness)
      color col = color(random(255.0), 255, 255);
      
      // Add Building Object to Our City
      Building b = new Building(x_temp, y_temp, base, tall, col);
      city.add(b);
    }
  }
}

void draw() {
  
  background(0); 
  stroke(255, 50);
  // 0 for black, 255 for white, #FF0000 for red, etc
  
  if (perspective) {
    // Format: camera(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ)
    camera(0.05*width, 0.95*height, 5.0*SCALE, 0.20*width, 0.75*height, 0.0, 0.0, 0.0, -1.0);
  } else {
    camera();
  }
  
  // Draw all of the buildings in our city
  for(Building b: city) {
    b.update();
    b.display2D();
    b.display3D();
  }
  
  // Change camera back to 2D mode for drawing text
  camera();
  fill(255);
  text("Press 'c' to change camera view", 10, SCALE);
  
}

// Fuction that allows you to program key commands
void keyPressed() {
  switch(key) {
    case 'c':
      perspective = !perspective;
      break;
  }
}
