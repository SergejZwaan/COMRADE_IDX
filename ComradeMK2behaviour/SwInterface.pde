class SwInterface{
  int autonomousMode =-1;
  int oldAutonomousMode = -1;
  int oldTestState = -1;
  String state;
  int time;
  int oldtime = 0;
  int difference = 50;
  
  String message = "";
  
  
  
  SwInterface(){
  
  
  
  }
  
  void run(){
      //time = millis();
      
      
      state = fsm.getState();
      switch (state){
         case "MANUAL": 
          autonomousMode = 0;
          break;
          
         case "AUTO": 
          autonomousMode = 1;
          break;
      }
      
      if(autonomousMode != oldAutonomousMode && testState != oldTestState){
         
         message =  "i" + autonomousMode + 'b' + testState + 'e';
         oldAutonomousMode = autonomousMode;
         oldTestState = testState;
         Comrade_Server.write(autonomousMode);
      }
     // if((time - oldtime) > difference){
     // oldtime = time;
     // Comrade_Server.write(autonomousMode);
     // }
      
      //println(autonomousMode);
  
  }



}