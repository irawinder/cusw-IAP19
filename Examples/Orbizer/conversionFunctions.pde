//Lat Lon to canvas position
float lattoCanvasY(float lat) {
  return canvas.height*(1.0-(lat+90)/180.0);
}

float lontoCanvasX(float lon) {
  return (lon+180)/360.0*canvas.width;
}

PVector latlontoCanvasXY(PVector latlon) {
  PVector pos = new PVector(lontoCanvasX(latlon.y), lattoCanvasY(latlon.x));
  return pos;
}

PVector windowXYtolatlon(float x, float y) {
  PVector LL = new PVector(((height-y)/height*180.0-90), ((x)/width*360.0-180));
  return LL;
}