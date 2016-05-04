class Grid{

  Grid(){
  
  }
  
  void run(){
    fill(240);
    rect(0,0,gridWidth,gridHeight);
    pushMatrix();
    translate(0,0,-0.5);
    fill(255);
    stroke(255);
    /*
    for(int i= 0; i<10;i++){
      for(int j = 0; j<10;j++){
        ellipse(i * (gridWidth/10) + (gridWidth/20), j * (gridHeight /10) + (gridWidth/30), 3,3);
       // point(i,j);
      }
    //draw_Road();
    }
    */
    popMatrix();
  }
}