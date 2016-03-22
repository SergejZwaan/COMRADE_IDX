class Behaviours {
  
  String state,type,action;
  String Ostate, Otype, Oaction;
  boolean ActionSwitch = false; // switch for actions that can only occure one time in one state
  int animationduration = 0;
  
  Behaviours() {
    println("System: Behaviours Activated");
    Ostate = null;
    Otype = null;
    Oaction = null;
  }

  void execute(String stateInput, String typeInput, String actionInput) {
    analyzeInput(stateInput, typeInput, actionInput);
    
    switch(state) {
    case "NULL":
      // run when state is null
      if (type == "RunState" && action == null) {
        comrade.Set_State(state);
        comrade.Set_Target(options.locationMax/2);
        comrade.Set_Bright(0.0);
        comrade.Set_Target_Red(0.0);
        comrade.Set_Target_Blue(0.0);
        comrade.Set_Velocity_Limit(1.0);
      }
      break;

    case "IDLE":
      // run when state is idle
      if (type == "RunState"  && action == null) {
        comrade.Set_State(state);
        comrade.Set_Target(options.locationMax/2);
        comrade.Set_Bright(1.0);
        comrade.Set_Target_Red(0.0);
        comrade.Set_Target_Blue(255.0);
        comrade.Set_Velocity_Limit(1.0);
      }
      break;

    case "AUTO":
      // run when state is auto
      if (type == "RunState"  && action == null) {
        comrade.Set_State(state);
        comrade.Set_Target(options.locationMax/4);
        comrade.Set_Velocity_Limit(3.0);
        comrade.Set_Drag(0.02);
      }
      break;


    case "MANUAL":
      // run when state is manual
      if (type == "RunState") {
        comrade.Set_State(state);
        comrade.Set_Target(options.locationMax/4*3);
        comrade.Set_Target_Red(0.0);
        comrade.Set_Target_Blue(255.0);
        comrade.Set_Velocity_Limit(3.0);
        comrade.Set_Drag(0.02);
      // run when can't switch to auto
      } else if(type == "RunAction" && action ==  "DENYSWITCHAUTO"){
        comrade.Set_Target_Red(255.0);
        comrade.Set_Target_Blue(0.0);
        comrade.Set_Velocity_Limit(8.0);
        comrade.Set_Target(options.locationMax/4*3 - 40);
        comrade.Set_Drag(0.0);
      }
      break;
     
     case "PAUZE":
     
      break;
    }
  }
  
  void analyzeInput(String stateInput, String typeInput, String actionInput){
    if(actionInput != Oaction){
      Oaction = action;
      action = actionInput;
    
    println(action);
    }
    
    state = stateInput;
    type = typeInput;
  }
}