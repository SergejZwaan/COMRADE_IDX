class FSM{

   String state = "NULL";
   String input = "NULL";
   String lastinput;
   String laststate;
   
   // create behaviour object
   Behaviours behaviour;
  
   // states
   // ----------------------------------------
   // auto
   // manual
   
   FSM(){
     println("System: FSM Activated");
     lastinput = "NULL"; 
     laststate = "NULL";
     behaviour = new Behaviours();
   }
   
   void run(){
     runFiniteStateMachine();
   }
   
   void runFiniteStateMachine(){
   
       // Switching states
       switch(state) {
        case "NULL": 
        
          behaviour.Execute_Null(state);
         
          if       (input == "SETAUTO")    {  setState("AUTO");}
          else if  (input == "SETMANUAL")  {  setState("MANUAL");}
          else if  (input == "SETIDLE")    {  setState("IDLE");}
          else
          break;
          
          
         case "IDLE": 
         
          behaviour.Execute_Idle(state);
         
          if       (input == "SETAUTO")       {setState("AUTO");}
          else if  (input == "SETNULL")       {setState("NULL"); }
          else if  (input == "SETMANUAL")     {setState("MANUAL");}
          else
          break;
          
          
        case "AUTO": 
        
          behaviour.Execute_Auto(state);
          
          if  (input == "SETMANUAL")  {  setState("MANUAL");}
          else if  (input == "SETNULL")       {setState("NULL"); }
          else if  (input == "SETIDLE")  {  setState("IDLE");}
          else
          break;
          
          
        case "MANUAL": 
          behaviour.Execute_Manual(state);
          
          if       (input == "SETAUTO")    {  setState("AUTO");}
          else if  (input == "SETNULL")       {setState("NULL"); }
          else if  (input == "SETIDLE")  {  setState("IDLE");}
          else 
          break;
        }
        
        // perform skills
        
   }
   
   
   private void setState(String Input){
     // check state change
     if(Input != laststate){
     state = Input;
     laststate = Input;
     println("fsm: set state to: " + state);
     }
     
   }
   
   // input function
   // filter for input changes
  public void write(String FSMInput){
    // if(FSMInput != lastinput){
     input = FSMInput;
     lastinput = FSMInput;
    // }
   } 

}