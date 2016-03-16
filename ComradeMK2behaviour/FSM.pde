class FSM{

   String state = "NULL";
   String input, inputGUI, inputComrade, inputSimulator = "NULL";
   String lastinput, lastinputgui, lastinputcomrade, lastinputsimulator;
   String laststate;
   
   // create behaviour object
   Behaviours behaviour;
  
   // states
   // ----------------------------------------
   // auto
   // manual
   
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
        
          behaviour.Execute_Null(state);
         
          if  (input == "SETIDLE")    {  setState("IDLE");}
          else
          break;
          
          
         case "IDLE": 
         
          behaviour.Execute_Idle(state);
         
          if       (input == "SETAUTO" && canDriveAutonomous())       {  setState("AUTO");}
          else if  (input == "SETAUTO" && !canDriveAutonomous())      {  println("no switch possible");}
          else if  (input == "SETNULL")       {  setState("NULL"); }
          else if  (input == "SETMANUAL")     {  setState("MANUAL");}
          else
          break;
          
          
        case "AUTO": 
        
          behaviour.Execute_Auto(state);
          
          if       (input == "SETMANUAL")     {  setState("MANUAL");}
          else if  (input == "SETNULL")       {  setState("NULL"); }
          else if  (input == "SETIDLE")       {  setState("IDLE");}
          else
          break;
          
          
        case "MANUAL": 
        
          behaviour.Execute_Manual(state);
          
          if       (input == "SETAUTO"  && canDriveAutonomous())       {  setState("AUTO");}
          else if  (input == "SETAUTO"  && !canDriveAutonomous())       {  println("no switch possible");}
          else if  (input == "SETNULL")       {  setState("NULL"); }
          else if  (input == "SETIDLE")       {  setState("IDLE");}
          else 
          break;
        }
        
        // perform skills
        
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