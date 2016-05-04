class GUI{
  String guiState;
  
  StartScreen startgui;      // Create object from StartScreen class, main gui
  ConfigScreen config;
  PlannerScreen planner;
  ScenarioScreen scenario;
  
  GUI(){
    startgui = new StartScreen();
    config = new ConfigScreen();
    planner = new PlannerScreen();
    scenario = new ScenarioScreen();
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
          c.set_Perspective("GUI");
      break;
      case "SIMULATOR":
          DemoDay.run();
          c.set_Perspective("SIMULATOR");
          pathplannerscreen = false;
      break;
      
      case "PATHPLANNER":
          c.set_Perspective("PATHPLANNER");
          pathplannerscreen = true;
          
      break;
      
      case "SHOWCASE":
          DemoDay.run();
          c.set_Perspective("SHOWCASE");
          pathplannerscreen = true;
      break;
      
      case "PLANNER":
          DemoDay.run();
          c.set_Perspective("PLANNER");
          planner.display();
      break;
      
      case "CONFIG":
          c.set_Perspective("CONFIG");
          config.display();
          pathplannerscreen = true;
      break;
      
        case "SCENARIO":
          DemoDay.run();
          c.set_Perspective("SCENARIO");
          scenario.display();
          
      break;
      
      default:
      
      break;
    
    }
  
  
  
  }
  
  void set_GUI_State(String input){
    guiState = input;
  }
  
  String get_GUI_State(){
    return guiState;
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
     set_GUI_State("SIMULATOR");
     startscreen = false;
     pathplannerscreen = false;
    } if (key == 'w'){
      firstperson = false;
      //endCamera();
    }if (key == 'x' ) {
      set_GUI_State("STARTSCREEN");
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
      set_GUI_State("SHOWCASE");
    }
    
  
    
    if (key == '1'){
      testState = 1;
    }if (key == '2'){
      testState = 2; 
    }if (key == '3'){
     testState = 3;
    }if (key == '4'){
      testState = 4;
    }if (key == '5'){
      testState = 5;
    } if (key == '0'){
      testState = 0;
    } 
  }
}


}