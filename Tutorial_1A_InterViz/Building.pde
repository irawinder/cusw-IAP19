class Building {
  
  // Where is the building
  float x, y;
  
  // How big is the base of the building
  float base;
  
  // How tall is the building
  float tall; 
  
  // Color of building
  color col;
  
  // scaler that adjusts attributes of building
  float scaler = 1.0;
  
  // Constructor for our building -> This is uses in our setup() function
  Building(float x, float y, float base, float tall, color col) {
    this.x = x;
    this.y = y;
    this.base = base;
    this.col = col;
    this.tall = tall;
  }
  
  void setScaler(float scaler) {
    this.scaler = scaler;
  }
  
  // This function is called to draw our building onto the canvas
  void display2D() {
    
    noFill();
    stroke(col);
    
    // Rectangles locations are drawn the top left corner, not the center!
    float topleft_x = x - 0.5*base;
    float topleft_y = y - 0.5*base;
    rect(topleft_x, topleft_y, base, base);
  }
  
    // This function is called to draw our building onto the canvas
  void display3D() {
    
    fill(col, 50);
    
    // Boxes are drawn from centroid at origin of current reference frame
    translate(x, y, 0.5*scaler*tall);
    box(base, base, scaler*tall);
    translate(-x, -y, -0.5*scaler*tall);
  }
}
