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

void gui(){
  
  if (keyPressed) {
    if (key == ENTER && autopilot == false) {
      autopilot = true;
      println("start autopilot");
    } if (key == 's'){
      if( start == false){
      car.setDriveStatus(true);
      start = true;
      println("start car");
      }
      else{
      car.setDriveStatus(false);
      start = false;
      println("stop car");
      }
    }if (key == 'q'){
     firstperson = true;
     
     startscreen = false;
     pathplannerscreen = false;
    } if (key == 'w'){
      firstperson = false;
      //endCamera();
    }if (key == 'x' && startscreen == false) {
      println("shift");
       autopilot = false;
       start = false;
       firstperson = false;
       startscreen = true;
       startpathplanner = false;
    } if (key == 'o'){
      comrade.Set_Manual_Drive();
    } if (key == 'p'){
      comrade.Set_Autonomous_Drive();
      
    }if (key == 'z'){
      update = true;
      
    }if (key == 'a'){
      update = false;
    }if (key == 'r'){
      car.reset();
    }
    
    
     // Controlling the comrade
     // Serial commands
     
    if(serialavailable && keycontrol){
          if (key == '0') {
            myPort.write ('0');
            //println("check");
          }
          if (key == '1') {
            myPort.write ('1');
          }
          if (key == '2') {
            myPort.write ('2');
          }
          if (key == '3') {
            myPort.write ('3');
          }
          if (key == '4') {
            myPort.write ('4');
          }
          if (key == '5') {
            myPort.write ('5');
          }
    }
  }
  
  
 

}