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

void gui(){
  
  if (keyPressed) {
    if (key == ENTER && autopilot == false) {
      autopilot = true;
      println("start autopilot");
    } if (key == 's'){
      if( start == false){
      car.setDriveStatus(true);
      println("start car");
      }
      else{
      car.setDriveStatus(false);
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
      // set autopilot false
      // set manual drive true
      autopilot = false;
      manualinput = true;
      //car.applyForce(new PVector(0,0));
      car.resetTheta();
      startpathplanner = false;
      controlState = 2;
    }if (key == 'p'){
      // set autopilot true
      // set manual drive false
      
    }if (key == 'z'){
      update = true;
      
    }if (key == 'a'){
      update = false;
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