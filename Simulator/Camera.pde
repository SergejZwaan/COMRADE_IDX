class Camera {

  String camPerspective;


  float Distance =-1.0;
  float cameraHeight = 0.0;
  float eyeHeight = 0.0;
  float theta = 0.0;
  PVector AdvancedCam;

  Camera() {
    // todo: add startscreen
    camPerspective = "GUI"; // start with the gui
    AdvancedCam = new PVector(0.0, 0.0);
  }

  void run() {

    switch(camPerspective) {
    case "GUI":
      top_View();
      break;

    case "SIMULATOR":
      advanced_cam_View();
      break;

    case "SHOWCASE":
      showcase_View();
      break;
      
     case "PLANNER":
      city_bottom_View();
      break;
      
     case "SCENARIO":
      city_high_View();
      break;

    default:
      city_top_View();
      break;
    }
  }

  void first_Person() {
    PVector eye = car.getLocation().copy();
    PVector camerapoint = car.getCameraLocation().copy();
    camera( camerapoint.x, camerapoint.y, -40, eye.x, eye.y, -40, 0, 0, 1);
  }

  void top_View() {
    frustum(-17.5, 17.5, -8.5, 8.5, 15, -300); // default frustum
    camera( gridWidth/2, gridHeight/2, 690, gridWidth/2, gridHeight/2, 0, 0, 1, 0);
  }

  void city_top_View() {
    camera( gridWidth/2, gridHeight/2, -690, gridWidth/2, gridHeight/2, 0, 0, 1, 0);
  }
  
  void city_bottom_View() {
    camera( gridWidth/2, gridHeight/2, 690, gridWidth/2, gridHeight/2, 0, 0, 1, 0);
  }
  
  void city_high_View() {
    camera( gridWidth/2, gridHeight/2, -990, gridWidth/2, gridHeight/2, 0, 0, 1, 0);
  }

  void advanced_cam_View() {
    advanced_Camera();
  }

  void advanced_Camera() {
    frustum(-20, 20, -20, 20, 10, 500);
    AdvancedCam = car.getLocation().copy();
    PVector carDistance = new PVector(100, 0);
    PVector camDistance = new PVector(10, 0);
    camDistance.rotate(car.getangle());
    carDistance.rotate(car.getangle());
    AdvancedCam.add(camDistance);
    pushMatrix();
    translate(0, 0, -10);
    popMatrix();
    PVector eye = car.getLocation().copy();
    eye.add(carDistance);
    camera( AdvancedCam.x, AdvancedCam.y, -20, eye.x, eye.y, -20, 0, 0, 1);
  }

  void showcase_View() {
    frustum(-20, 20, -20, 20, 10, 500);
    AdvancedCam = car.getLocation().copy();
    PVector camDistance = new PVector(-50, 0);
    camDistance.rotate(theta);
    theta += 0.005;
    AdvancedCam.add(camDistance);   
    pushMatrix();
    translate(0, 0, -10);
    popMatrix();
    PVector eye = car.getLocation().copy();
    camera( AdvancedCam.x, AdvancedCam.y, -60, eye.x, eye.y, -10, 0, 0, 1);
  }

  // input functions
  void set_Perspective(String input) {camPerspective = input;}

  // return functions
  String get_Perspective() {return camPerspective;}
}