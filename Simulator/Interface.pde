class Interface{

  Interface(){
  
  }
  
  void Set_Manual_Drive(){
      autopilot = false;
      manualinput = true;
      car.applyForce(new PVector(0,0));
      p.resetPathPlanner();
      startpathplanner = false;
  
  }
  
  void Set_Autonomous_Drive(){
      manualinput = false;
      car.resetTheta();
      autopilot = true;
      p.startAutonomousDriving(autopilot);
      startpathplanner = true;
      controlState = 1;
  }




}