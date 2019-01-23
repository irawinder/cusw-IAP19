PImage loadingBG;
void loadingScreen(PImage bg, int phase, int numPhases, String status) {
  background(0); image(bg, 0, 0, width, height);
  pushMatrix(); translate(width/2, height/2);
  int lW = 400;
  int lH = 48;
  int lB = 10;
  
  // Draw Loading Bar Outline
  //
  noStroke(); fill(255, 200);
  rect(-lW/2, -lH/2, lW, lH, lH/2);
  noStroke(); fill(0, 200);
  rect(-lW/2+lB, -lH/2+lB, lW-2*lB, lH-2*lB, lH/2);
  
  // Draw Loading Bar Fill
  //
  float percent = float(phase)/numPhases;
  noStroke(); fill(255, 150);
  rect(-lW/2 + lH/4, -lH/4, percent*(lW - lH/2), lH/2, lH/4);
  
  textAlign(CENTER, CENTER); fill(255);
  text(status, 0, 0);
  
  popMatrix();
}