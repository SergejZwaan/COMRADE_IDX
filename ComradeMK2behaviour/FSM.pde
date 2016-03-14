class FSM{

   String state = "NULL";
   String input = "NULL";
   String lastinput;
  
   // states
   // ----------------------------------------
   // auto
   // manual
   
   FSM(){
     lastinput = "NULL";  
   }
   
   void run(){
     runFiniteStateMachine();
   }
   
   void runFiniteStateMachine(){
   
       switch(state) {
        case "NULL": 
          if       (input == "SETAUTO")    {  setState("AUTO");}
          else if  (input == "SETMANUAL")  {  setState("MANUAL");}
          
          else
          break;
        case "AUTO": 
          if  (input == "SETMANUAL")  {  setState("MANUAL");}
          else if  (input == "NULL")       { }
          
          else
          break;
        case "MANUAL": 
          if       (input == "SETAUTO")    {  setState("AUTO");}
          else if  (input == "NULL")       { }
          
          else
          break;
        }

   }
   
   void setState(String Input){
      state = Input;
      println("fsm: set state to: " + state);
      
   }
   
   // input function
   // filter for input changes
   void write(String FSMInput){
     if(FSMInput != lastinput){
     input = FSMInput;
     lastinput = FSMInput;
     }
   } 

}