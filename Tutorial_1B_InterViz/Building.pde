class Building {
  float x, y; // building location
  float base; // size of the building base
  color col;
  
  float scaler = 1.0;
  
  Building(float x, float y, float base, color col) {
    this.x = x;
    this.y = y;
    this.base = base;
    this.col = col;
  }
  
  void update() {
    float distX = mouseX - x;
    float distY = mouseY - y;
    scaler = 5.0 * sq( max( 0.0, 1.0 - sqrt( sq(distX) + sq(distY))/height ));
  }
  
  void display2D() {
    noFill();
    stroke(col);
    
    float topleft_x = x - 0.5*base;
    float topleft_y = y - 0.5*base;
    
    rect(topleft_x, topleft_y, base*scaler, base*scaler);
  }
}
