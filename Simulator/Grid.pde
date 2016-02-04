class Grid{

  Grid(){
  
  }
  
  void run(){
    fill(30);
    rect(0,0,gridWidth,gridHeight);
    pushMatrix();
    translate(0,0,-0.5);
    fill(255);
    stroke(255);
    for(int i= 0; i<10;i++){
      for(int j = 0; j<10;j++){
        ellipse(i * (gridWidth/10) + (gridWidth/20), j * (gridHeight /10) + (gridWidth/30), 3,3);
       // point(i,j);
      }
    //draw_Road();
    }
    popMatrix();
  }
  
  void draw_Road(){
  
    fill(30);
    beginShape();
      int outerdistance = 100;
      int innerdistance = 200;
      //outersquare
      line(outerdistance,outerdistance,outerdistance,gridHeight-outerdistance);
      line(outerdistance,gridHeight-outerdistance,gridWidth-outerdistance,gridHeight-outerdistance);
      line(gridWidth-outerdistance,gridHeight-outerdistance,gridWidth-outerdistance,outerdistance);
      line(gridWidth-outerdistance,outerdistance,outerdistance+1,outerdistance);
      
      line(innerdistance,innerdistance,innerdistance,gridHeight-innerdistance);
      line(innerdistance,gridHeight-innerdistance,gridWidth-innerdistance,gridHeight-innerdistance);
      line(gridWidth-innerdistance,gridHeight-innerdistance,gridWidth-innerdistance,innerdistance);
      line(gridWidth-innerdistance,innerdistance,innerdistance+1,innerdistance);
      
      line(outerdistance,outerdistance,innerdistance,innerdistance);
      line(innerdistance+1,innerdistance,outerdistance+1,outerdistance);
    endShape();
  
  }



}