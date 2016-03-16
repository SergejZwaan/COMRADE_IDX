class Behaviours{

    Behaviours(){
    println("System: Behaviours Activated");
    }
    
     void Execute_Null(String state){
      comrade.Set_State(state);
      comrade.Set_Target(options.locationMax/2);
      comrade.Set_Bright(0.0);
    }
    
     void Execute_Idle(String state){
      comrade.Set_State(state);
      comrade.Set_Target(options.locationMax/2);
      comrade.Set_Bright(1.0);
    }
    
     void Execute_Auto(String state){
      comrade.Set_State(state);
      comrade.Set_Target(options.locationMax/4);
    }
    
     void Execute_Manual(String state){
      comrade.Set_State(state);
      comrade.Set_Target(options.locationMax/4*3);
    }

}