class Camera{

 // PVector[] camSnake = new PVector[10];
  float Distance =-1.0;
  float cameraHeight = 0.0;
  float eyeHeight = 0.0;
  PVector AdvancedCam;
  
  Camera(){
 
     AdvancedCam = new PVector(0.0,0.0);
     frustum(-20, 20, -20, 20, 10, 500);
  }
  
  void run(){
     
     
     //if(firstperson == true){first_Person();}
     //if(firstperson == false){top_View();}
     
    AdvancedCam = car.getLocation().copy();
    PVector camDistance = new PVector(Distance,0);
    camDistance.rotate(car.getangle());
    AdvancedCam.add(camDistance);
    //PVector camerapoint = car.getCameraLocation().copy();
    
    pushMatrix();
     translate(0,0,-10);
     ellipse(AdvancedCam.x, AdvancedCam.y, 10,10);
     popMatrix();
     
     PVector eye = car.getLocation().copy();
    camera( AdvancedCam.x, AdvancedCam.y, -40, eye.x, eye.y, -40, 0, 0, 1);
    
     //city_top_View();
  }
  
  void first_Person(){
    PVector eye = car.getLocation().copy();
    PVector camerapoint = car.getCameraLocation().copy();
    camera( camerapoint.x, camerapoint.y, -40, eye.x, eye.y, -40, 0, 0, 1);
  }
  
  void top_View(){
    camera( gridWidth/2, gridHeight/2, 690, gridWidth/2, gridHeight/2, 0, 0, 1, 0);
  }
  
  void city_top_View(){
    camera( gridWidth/2, gridHeight/2, -800, gridWidth/2, gridHeight/2, 0, 0, 1, 0);
  }
  
  void advanced_cam_View(){
    advanced_Camera();
  }
  
  void advanced_Camera(){
    
  }
  
}