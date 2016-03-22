class FSM{

   String state = "NULL";
   String input, inputGUI, inputComrade, inputSimulator = "NULL";
   String lastinput, lastinputgui, lastinputcomrade, lastinputsimulator;
   String laststate;
   
   // create behaviour object
   Behaviours behaviour;
  
   // states
   // ----------------------------------------
   
   FSM(){
     println("System: FSM Activated");
     lastinputgui = "NULL";
     lastinputcomrade = "NULL"; 
     lastinputsimulator = "NULL"; 
     laststate = "NULL";
     behaviour = new Behaviours();
   }
   
   void run(){
     runFiniteStateMachine();
   }
   
   boolean canDriveAutonomous(){
     boolean output;
     if(CanDrive > 75){output = true;} else{ output = false;}
     return output;
   }
   
   // Finite state machine
   void runFiniteStateMachine(){
     
       // Switching states
       switch(state) {
         case "NULL": 
        
          behaviour.execute(state, "RunState", null);
                if  (input == "SETIDLE")    {  setState("IDLE");  }
          else  if  (input == "SETAUTO")    {  setState("NULL");  }
          else  if  (input == "SETMANUAL")  {  setState("NULL");  }
          break;
          
          
         case "IDLE": 
         
          behaviour.execute(state, "RunState", null);
               if  (input == "SETAUTO"   && system.CanDriveAutonomous())       {  setState           ("AUTO");             }
          else if  (input == "SETAUTO"   && !system.CanDriveAutonomous())      {  behaviour.execute  (state, "RunAction" , "DENYSWITCHAUTO");    }
          else if  (input == "SETNULL")                                        {  setState           ("NULL");             }
          else if  (input == "SETMANUAL" && system.CanDriveManual())           {  setState           ("MANUAL");           }
          else if  (input == "SETMANUAL" && !system.CanDriveManual())          {  println            ("no switch possible");}
          else
          break;
          
          
        case "AUTO": 
        
          behaviour.execute(state, "RunState", null);
               if  (input == "SETMANUAL")     {  setState("MANUAL");}
          else if  (input == "SETNULL")       {  setState("NULL"); }
          else if  (input == "SETIDLE")       {  setState("IDLE");}
          else
          break;
          
          
        case "MANUAL": 
        
          behaviour.execute(state, "RunState", null);
               if  (input == "SETAUTO"  && canDriveAutonomous())       {  setState("AUTO");}
          else if  (input == "SETAUTO"  && !canDriveAutonomous())      {  behaviour.execute  (state, "RunAction" , "DENYSWITCHAUTO");  }
          else if  (input == "SETNULL")       {  setState("NULL"); }
          else if  (input == "SETIDLE")       {  setState("IDLE");}
          else 
          break;
        }
        
        
   }
   
   // state parser
   private void setState(String Input){
     // check state change
     if(Input != laststate){
     state = Input;
     laststate = Input;
     println("fsm: set state to: " + state);
     }
   }
   
   // input function
  public void write(String Type, String FSMInput){
     // if input type is gui and input gui is true
     if(Type == "gui" && options.inputGui == true){
       input = FSMInput;
       lastinput = FSMInput;
     }
     
     // prototype input
     else if(Type == "comrade" && options.inputComrade == true){
       input = FSMInput;
       lastinputcomrade = FSMInput;
     }
  } 

}