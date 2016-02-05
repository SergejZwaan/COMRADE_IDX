class Camera{

  Camera(){

  }
  
  void run(){
  
     if(firstperson == true){first_Person();}
     if(firstperson == false){top_View();}
    
  }
  
  void first_Person(){
    PVector eye = car.getLocation().copy();
    PVector camerapoint = car.getCameraLocation().copy();
    camera( camerapoint.x, camerapoint.y, -40, eye.x, eye.y, -40, 0, 0, 1);
  
  }
  
  void top_View(){
    camera( gridWidth/2, gridHeight/2, 690, gridWidth/2, gridHeight/2, 0, 0, 1, 0);
  }
  

}