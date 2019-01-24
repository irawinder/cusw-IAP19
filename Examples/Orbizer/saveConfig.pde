Table config;

void saveConfig() {
  
  config = new Table();
  
  config.addColumn("id");
  config.addColumn("value");
  
  TableRow newRow = config.addRow();
  newRow.setString("id", "displayMode");
  newRow.setString("value", displayMode);
  
  //Booleans
  newRow = config.addRow();
  newRow.setString("id", "showVertexEdges");
  newRow.setInt("value", int(showVertexEdges));
  
  newRow = config.addRow();
  newRow.setString("id", "showReducedResolution");
  newRow.setInt("value", int(showReducedResolution));
  
  newRow = config.addRow();
  newRow.setString("id", "showFrameRate");
  newRow.setInt("value", int(showFrameRate));
  
  newRow = config.addRow();
  newRow.setString("id", "showAutoRotate");
  newRow.setInt("value", int(showAutoRotate));
  
  newRow = config.addRow();
  newRow.setString("id", "showAgents");
  newRow.setInt("value", int(showAgents));
  
  //Sphere
  newRow = config.addRow();
  newRow.setString("id", "pitch3d");
  newRow.setFloat("value", pitch3d.value);
  
  newRow = config.addRow();
  newRow.setString("id", "zoom3d");
  newRow.setFloat("value", zoom3d.value);
  
  newRow = config.addRow();
  newRow.setString("id", "rotate3d");
  newRow.setFloat("value", rotate3d.value);
  
  //Projection
  newRow = config.addRow();
  newRow.setString("id", "w45min");
  newRow.setFloat("value", w45min.value);
  
  newRow = config.addRow();
  newRow.setString("id", "weq");
  newRow.setFloat("value", weq.value);
  
  newRow = config.addRow();
  newRow.setString("id", "w45max");
  newRow.setFloat("value", w45max.value);
  
  newRow = config.addRow();
  newRow.setString("id", "translateX");
  newRow.setFloat("value", translateX.value);
  
  newRow = config.addRow();
  newRow.setString("id", "translateY");
  newRow.setFloat("value", translateY.value);
  
  newRow = config.addRow();
  newRow.setString("id", "rotate");
  newRow.setFloat("value", rotate.value);
  
  newRow = config.addRow();
  newRow.setString("id", "zoom");
  newRow.setFloat("value", zoom.value);
  
  newRow = config.addRow();
  newRow.setString("id", "flipMap");
  newRow.setInt("value", int(flipMap));
  
  newRow = config.addRow();
  newRow.setString("id", "mapIndex");
  newRow.setInt("value", mapIndex);
  
  saveTable(config, "data/config.csv");
}

void loadConfig() {
  
  File f = new File(dataPath("config.csv"));
  if(f.exists()) { 

    config = loadTable("config.csv","header");
  
    for(TableRow row : config.rows()) {
      switch (row.getString("id")) {
            //Booleans 6 values
            case "showVertexEdges" :  showVertexEdges = boolean(row.getInt("value"));
                     break;
            case "showReducedResolution" :  showReducedResolution = boolean(row.getInt("value"));
                     break;
            case "showFrameRate" :  showFrameRate = boolean(row.getInt("value"));
                     break;
            case "showAutoRotate" :  showAutoRotate = boolean(row.getInt("value"));
                     break;
            case "showAgents" :  showAgents = boolean(row.getInt("value"));
                     break;
            case "flipMap" :  flipMap = boolean(row.getInt("value"));
                     break;
            //Sphere 3 values
            case "pitch3d" :  pitch3d.value = row.getFloat("value");
                     break;
            case "zoom3d" :  zoom3d.value = row.getFloat("value");
                     break;
            case "rotate3d" :  rotate3d.value = row.getFloat("value");
                     break;
            //Projection 7 values
            case "w45min" :  w45min.value = row.getFloat("value");
                     break;
            case "weq" :  weq.value = row.getFloat("value");
                     break;
            case "w45max" :  w45max.value = row.getFloat("value");
                     break;
            case "translateX" :  translateX.value = row.getFloat("value");
                     break;
            case "translateY" :  translateY.value = row.getFloat("value");
                     break;
            case "rotate" :  rotate.value = row.getFloat("value");
                     break;
            case "zoom" :  zoom.value = row.getFloat("value");
                     break;
            //Integer 1 value
            case "s_map" :  s_map.value = row.getInt("value");
                     break;
      }
    }
  
    //DisplayMode
    //displayMode = config.getString(0,1);
  }
  else restoreDefaults();
}