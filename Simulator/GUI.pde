class GUI{
  String guiState;
  
  StartScreen startgui;      // Create object from StartScreen class, main gui
  
  GUI(){
    startgui = new StartScreen();
    guiState = "STARTSCREEN";  
  }
  
  void run(){
    keyboard_Control();
    GUI_FSM();
  }
  
  void GUI_FSM(){
    
    switch(guiState){
      case "STARTSCREEN":
          startgui.run();
      break;
      case "SIMULATOR":
          c.set_Perspective("SIMULATOR");
          pathplannerscreen = false;
      break;
      
      default:
      
      break;
    
    }
  
  
  
  }
  
  void set_GUI_State(String input){
    guiState = input;
  }
  
  
  void keyboard_Control(){
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
     c.set_Perspective("SIMULATOR");
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
       c.set_Perspective("GUI");
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
    }if (key == 'l'){
      c.set_Perspective("SHOWCASE");
    } 
  }
}


}