PShape s;
ArrayList<PVector> building = new ArrayList<PVector>();
void setup(){
  size(800, 800); 
  
  building = new ArrayList<PVector>();
  //new PVector(x, y)
  building.add(new PVector(200, 300));
  building.add(new PVector(300, 300));
  building.add(new PVector(300, 500));
  building.add(new PVector(200, 500));
  building.add(new PVector(150, 400));
  building.add(new PVector(200, 300));
  
  s = createShape();
  s.beginShape();
  for(int i = 0; i<building.size(); i++){
    s.vertex(building.get(i).x, building.get(i).y);
  }
  s.endShape();
  
  
}

void draw(){
  background(255);
  
  shape(s, 0, 0);
  
  float x = 20;
  float y = 20;
  
  ellipse(x, y, 10, 10);
  
  //draw from 2 points
  float x1 = 5;
  float y1 = 5;
  float x2 = 50;
  float y2 = 50;
  line(x1, y1, x2, y2);
  
  //Polygon! 
  
  
}
