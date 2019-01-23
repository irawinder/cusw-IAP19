import java.util.*;

PVector pt;
ArrayList<ArrayList<PVector>> lines; 
ArrayList<PVector> building;
PShape s;
  
void setup(){
  size(800, 800);
  //Make a random pt
  pt = new PVector(random(20, width - 20), random(20, height-20));
  
  lines = new ArrayList<ArrayList<PVector>>();
  for(int i =0; i<20; i++){
        ArrayList<PVector> pts = new ArrayList<PVector>();
        pts.add(new PVector(i*2*(i+1), 10*(i+1)));
        pts.add(new PVector(i*2*(i+2), 10*(i+2)));
        lines.add(pts);
  }
  
  building = new ArrayList<PVector>();
  building.add(new PVector(200, 300));
  building.add(new PVector(300, 300));
  building.add(new PVector(300, 500));
  building.add(new PVector(200, 500));
  building.add(new PVector(150, 400));
  building.add(new PVector(200, 300));
  s = createShape();
  
  makeBuilding(building);
}

void draw(){
  background(255);
  drawPoint(pt);
  drawBuilding();
  drawLines(lines);
}

void drawPoint(PVector _pt){
  fill(255, 0, 0);
  noStroke();
  ellipse(_pt.x, _pt.y, 15, 15);
}

void drawLines(ArrayList<ArrayList<PVector>> _lines){
    for(int i = 0; i< _lines.size(); i++){
    PVector start = _lines.get(i).get(0);
    PVector end = _lines.get(i).get(1);
    strokeWeight(2);
    stroke(0, 200, 0);
    line(start.x, start.y, end.x, end.y);
  }
}

void makeBuilding(ArrayList<PVector> _points){
  s.beginShape();
  for(int i =0; i<_points.size(); i++){
    s.vertex(_points.get(i).x, _points.get(i).y);
  }
  s.endShape();
}

void drawBuilding(){
  shape(s, 0, 0);
}
