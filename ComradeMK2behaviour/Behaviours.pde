class Behaviours {
  
  String state,type,action;
  String Ostate, Otype, Oaction;
  boolean ActionSwitch = false; // switch for actions that can only occure one time in one state
  int animationcounter = 0;
  
  int animationsetcounter = 0;
  
  Behaviours() {
    println("System: Behaviours Activated");
    Ostate = null;
    Otype = null;
    Oaction = null;
  }

  void execute(String stateInput) {
    analyzeInput(stateInput);
    
    switch(state) {
    case "NULL":
      // run when state is null
       
        comrade.Set_State(state);
        comrade.Set_Target(options.locationMax/2);
        comrade.Set_Bright(0.0);
        comrade.Set_Target_Red(0.0);
        comrade.Set_Target_Blue(0.0);
        comrade.Set_Velocity_Limit(1.0);
       // comrade.Set_Location(new PVector(options.locationMax/2,0));
      
      break;

    case "IDLE":
      // run when state is idle
      
        comrade.Set_State(state);
        comrade.Set_Target(options.locationMax/2);
        comrade.Set_Bright(1.0);
        comrade.Set_Target_Red(0.0);
        comrade.Set_Target_Blue(255.0);
        comrade.Set_Velocity_Limit(1.0);
        //comrade.Set_Location(new PVector(options.locationMax/2,0));
      
      break;

    case "AUTO":
      // run when state is auto
      
        comrade.Set_State(state);
        comrade.Set_Target(options.locationMax/4);
        comrade.Set_Velocity_Limit(6.0);
        comrade.Set_Drag(0.02);
        comrade.Set_Target_Red(0.0);
        comrade.Set_Target_Blue(255.0);
      
      break;


    case "MANUAL":
      // run when state is manual
      
        comrade.Set_State(state);
        comrade.Set_Target(options.locationMax/4*3.5);
        comrade.Set_Target_Red(0.0);
        comrade.Set_Target_Blue(255.0);
        comrade.Set_Velocity_Limit(6.0);
        comrade.Set_Drag(0.02);
      break;
     
   case "DENYSWITCHAUTO":
        
        if(animationcounter <200){
        systemPrint(state);
        comrade.Set_Target_Red(255.0);
        comrade.Set_Target_Blue(0.0);
        comrade.Set_Velocity_Limit(9.0);
        comrade.Set_Target(options.locationMax/4*3 - 40);
        comrade.Set_Drag(0.0);
        animationcounter++;
        }else {
        animationcounter=0;
        fsm.write("system","SETMANUAL");
        }
      break;
      
    case "DENYSWITCHMANUAL":
        
        if(animationcounter <200){
        systemPrint(state);
        comrade.Set_Target_Red(255.0);
        comrade.Set_Target_Blue(0.0);
        comrade.Set_Velocity_Limit(9.0);
        comrade.Set_Target(options.locationMax/4 + 40);
        comrade.Set_Drag(0.0);
        animationcounter++;
        }else {
        animationcounter=0;
        fsm.write("system","SETAUTO");
        }
      break;
      
    case "WANT_AUTO":
       
        systemPrint(state);
        if(animationcounter<=200){
        comrade.Set_Target_Blue(255.0);
        comrade.Set_Velocity_Limit(9.0);
        comrade.Set_Target(options.locationMax/4*3 - 40);
        comrade.Set_Drag(0.0);
        comrade.Set_stretch(true);
        animationcounter++;
        }else if(animationcounter > 200 && animationcounter < 250){
        comrade.Set_Target(options.locationMax/4*3);
        comrade.Set_Drag(0.01);
        comrade.Set_Velocity_Limit(3.0);
        animationcounter++;
        }else animationcounter = 2;
        
      break;
    case "WANT_MANUAL":
        
        // make speed dependant of the can autonomous drive percentage
        int velocityLimit = 140/ (system.getDriveAutoSum() +15);
        systemPrint(state);
        if(animationcounter<=200){
        comrade.Set_Target_Blue(255.0);
        comrade.Set_Target(options.locationMax/4 + 8*velocityLimit);
        comrade.Set_Drag(0.0);
        comrade.Set_Velocity_Limit(1.0 * velocityLimit);
        animationcounter++;
        }else if(animationcounter > 200 && animationcounter < 250){
        comrade.Set_Target(options.locationMax/4);
        comrade.Set_Drag(0.01);
        comrade.Set_Velocity_Limit(0.5 * velocityLimit);
        animationcounter++;
        } else animationcounter = 2;
        
        
        
      break;
    }
    
    
  }
  
  void systemPrint(String inputState){
    if(animationcounter == 1){
    println("fsm: execute action: " + inputState);
    }
  }
  
  void analyzeInput(String stateInput){
    if(stateInput != Ostate){
      Ostate = stateInput;
      state = stateInput;
    }
    
  }
}