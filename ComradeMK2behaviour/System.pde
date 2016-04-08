class System{

  private int candriveAUTOsum;
  private int candriveMANUALsum;
  
  System(){
    
  }
  
  void run(){
    Analyze_CanDrive();
    Execute_HWInput();
    CanDrive = candriveAUTOsum;
  }
  
  void Analyze_CanDrive(){
   
    candriveAUTOsum = 0;
    candriveMANUALsum = 100;
    
    //Auto
    
    candriveAUTOsum += Radar/2;
    candriveAUTOsum += GPS/2;
    CanDrive = candriveAUTOsum;  
    
    if(Snow){candriveAUTOsum = 0;}
    if(Rain){candriveAUTOsum = 0;}
    if(Dark){candriveAUTOsum = 0;}
    
    // Manual
    if(Platoon){candriveMANUALsum = 0;}
    if(AHWay){candriveMANUALsum = 0;}
    if(Manouvre){candriveMANUALsum = 0;}
    
    
  }
  
  void Execute_HWInput(){
  
    int[] swipeCounter = hw. getSwipeCounter();
    
    if(swipeCounter[0] > 20){
      fsm.write("system","SETAUTO");
    }
    
    if(swipeCounter[1] > 20){
      fsm.write("system","SETMANUAL");
    }
  
  
  
  }
  
  boolean CanDriveAutonomous(){
    if(candriveAUTOsum >= 75 ){return true;}
    else{return false;}
    
  }
  
  boolean CanDriveManual(){
    if(candriveMANUALsum >= 75 ){return true;}
    else{return false;}
  }
  
  int getDriveAutoSum(){
    return candriveAUTOsum;
  }







}