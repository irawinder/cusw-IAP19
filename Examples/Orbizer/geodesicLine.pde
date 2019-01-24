void drawLine(float lat1, float lon1,float lat2, float lon2, int segments) {
  //Thanks www.movable-type.co.uk/scripts/latlong.html for the math on this
  
  //calculate distance between points
  float rlat1 = lat1*PI/180;
  float rlon1 = lon1*PI/180;
  float rlat2 = lat2*PI/180;
  float rlon2 = lon2*PI/180;
  
  float a = sin((rlat1-rlat2)/2)*sin((rlat1-rlat2)/2) + cos(rlat1)*cos(rlat2) * sin((rlon1-rlon2)/2)*sin((rlon1-rlon2)/2);
  float angDist = 2*atan2(sqrt(a),sqrt(1-a));
  
  //f is the fraction of the way along the path between 0-1
  float f = 0;
  
  PVector latlon = new PVector(rlat1,rlon1);
  
  PVector newUV = new PVector();
  PVector oldUV = new PVector();
  newUV = latlontoUV(latlon);
  oldUV = newUV;
  
  //canvas.stroke(#FFFFFF, 100);
  //canvas.strokeWeight(3);
  
  for(int i=0;i<=segments;i++) {  
    latlon = calcInter(rlat1, rlon1, rlat2, rlon2, angDist, float(i)/float(segments));
    newUV = latlontoUV(latlon);
    
    //Do the pacific wrap correction if the UV positions are most of the canvas width.
    if(((oldUV.x-newUV.x) > 0.9*canvas.width) || ((newUV.x-oldUV.x) > 0.9*canvas.width)) pacificWrap(oldUV, newUV);
    else canvas.line(oldUV.x,oldUV.y,newUV.x,newUV.y);
    
    oldUV = newUV;
  }
}
PVector calcInter(float lt1, float ln1, float lt2, float ln2, float d, float f) {
  
  float a = sin((1-f)*d)/sin(d);
  float b = sin(f*d)/sin(d);
  float x = a*cos(lt1)*cos(ln1) + b*cos(lt2)*cos(ln2);
  float y = a*cos(lt1)*sin(ln1) + b*cos(lt2)*sin(ln2);
  float z = a*sin(lt1) + b*sin(lt2);
  
  float latVal = atan2(z,sqrt(x*x+y*y));
  float lonVal = atan2(y,x); 
  
  PVector point = new PVector(latVal,lonVal);
  return point;
}

float calcBearing(float lt1, float ln1, float lt2, float ln2) {
  float c = PI/180;
  return atan2( sin((ln2-ln1)*c) * cos(lt2*c),  cos(lt1*c)*sin(lt2*c) - sin(lt1*c)*cos(lt2*c)*cos((ln2-ln1)*c))/c;
}

float calcAngDist(float lt1, float ln1, float lt2, float ln2) {
  float c = PI/180;
  float a = sin((lt1-lt2)*c/2)*sin((lt1-lt2)*c/2) + cos(lt1*c)*cos(lt2*c) * sin((ln1-ln2)*c/2)*sin((ln1-ln2)*c/2);
  return 2*atan2(sqrt(a),sqrt(1-a))/c;
}

PVector latlontoUV(PVector latlon) {
  PVector UV = new PVector();
  UV.x = (latlon.y*180/PI+180)*map.width/360;
  UV.y = (90-latlon.x*180/PI)*map.height/180;
  return UV;
}

void pacificWrap(PVector oldUV, PVector newUV) {
  //Determine if we are moving east or west
  if(oldUV.x < canvas.width/2) {
    canvas.line(oldUV.x,oldUV.y,newUV.x-canvas.width,newUV.y);
    canvas.line(oldUV.x+canvas.width,oldUV.y,newUV.x,newUV.y);
  } else {
    canvas.line(oldUV.x,oldUV.y,newUV.x+canvas.width,newUV.y);
    canvas.line(oldUV.x-canvas.width,oldUV.y,newUV.x,newUV.y);
  }
}