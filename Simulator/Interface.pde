class Interface{
  Interface(){
  }
  
  void Set_Manual_Drive(){
      autopilot = false; // turn of autopilot
      manualinput = true; // turn on keyboard input
      car.applyForce(new PVector(0,0)); // apply no force
      p.resetPathPlanner();  // reset path planner
      startpathplanner = false; // stop running pathplanner
  }
  
  void Set_Autonomous_Drive(){
      manualinput = false; // manual input is false
      car.resetTheta(); // reset the car steering angle
      autopilot = true; // set autopilot true
      p.startAutonomousDriving(autopilot); // start autopilot
      startpathplanner = true; // start pathplanner
  }
}