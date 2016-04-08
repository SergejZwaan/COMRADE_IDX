class FSM{

   String state = "NULL";
   String input, inputGUI, inputComrade, inputSimulator = "NULL";
   String lastinput, lastinputgui, lastinputcomrade, lastinputsystem, lastinputsimulator;
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

   // Finite state machine
   void runFiniteStateMachine(){
     
       // Switching states
       switch(state) {
         case "NULL": 
          behaviour.execute(state);
                if  (input == "SETIDLE")    {  setState("IDLE");  }
          else  if  (input == "SETAUTO")    {  setState("NULL");  }
          else  if  (input == "SETMANUAL")  {  setState("NULL");  }
         break;
          
          
         case "IDLE": 
          behaviour.execute(state);
               if  (input == "SETAUTO"   && system.CanDriveAutonomous())       {  setState           ("AUTO");             }
          else if  (input == "SETNULL")                                        {  setState           ("NULL");             }
          else if  (input == "SETMANUAL" && system.CanDriveManual())           {  setState           ("MANUAL");           }
          else if  (input == "SETMANUAL" && !system.CanDriveManual())          {  setState           ("IDLE");             }
          
          else if  (input == "SETMANUAL" && system.CanDriveManual() && !leftHand)          {  println("place hands on the steer");            }
          else if  (input == "SETAUTO"   && system.CanDriveAutonomous() && !leftHand)      {  println("place hands on the steer");            }
          break;

        case "AUTO": 
          behaviour.execute(state);
               if  (!system.CanDriveAutonomous()) {  setState("WANT_MANUAL");}
          else if  (input == "SETMANUAL" &&  system.CanDriveManual() && leftHand)     {  setState("MANUAL");}
          else if  (input == "SETMANUAL"  && !system.CanDriveManual())        {  behaviour.execute("DENYSWITCHMANUAL");  }
          else if  (input == "SETNULL")       {  setState("NULL"); }
          else if  (input == "SETIDLE")       {  setState("IDLE");}
          else if  (input == "SETWANTMANUAL") {  setState("WANT_MANUAL");}
          
          
          
          else if  (input == "SETMANUAL" && system.CanDriveManual() && !leftHand)          {  println("place hands on the steer");            }
         
          
          // maintain state
          
          break;

        case "MANUAL": 
          behaviour.execute(state);
               if  (input == "SETAUTO"  && system.CanDriveAutonomous() && leftHand)       {  setState("AUTO");}
          else if  (input == "SETAUTO"   && system.CanDriveAutonomous() && !leftHand)      {  println("place hands on the steer");            }
          else if  (input == "SETAUTO"  && !system.CanDriveAutonomous())      {  behaviour.execute("DENYSWITCHAUTO"); }
          else if  (input == "SETMANUAL"  && system.CanDriveManual())         {  setState("MANUAL");  }
          else if  (input == "SETNULL")       {  setState("NULL"); }
          else if  (input == "SETIDLE")       {  setState("IDLE");}
          else if  (input == "SETWANTAUTO"  && system.CanDriveAutonomous())   {  setState("WANT_AUTO"); }
          else if  (input == "SETWANTAUTO"  && !system.CanDriveAutonomous())   {  setState("MANUAL"); }
          else if  (!system.CanDriveManual()) {  setState("WANT_AUTO");}
          
         
          
          break;

        case "WANT_AUTO": 
          behaviour.execute(state);
          if  (input == "SETAUTO" )       { setState("AUTO"); }
          else if  (system.CanDriveManual()) {  setState("MANUAL");}
          break;
          
        case "WANT_MANUAL": 
          behaviour.execute(state);
          if  (input == "SETMANUAL")     { setState("MANUAL"); }
          else if  (system.CanDriveAutonomous()) {  setState("AUTO");}
          else
          break;
          
        case "nothing":
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
     
     else if(Type == "system" && options.inputSystem == true){
       input = FSMInput;
       lastinputsystem = FSMInput;
     }
  } 

}