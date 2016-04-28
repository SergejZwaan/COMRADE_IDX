class System{

  private int candriveAUTOsum;
  private int candriveMANUALsum;
  
  float candriveTarget;
  float candriveNetto;
  float candriveH;
  
  System(){
    candriveNetto = 100.0;
    candriveH = 0.1;
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
    
    if(mode == "USERTEST"){
    // set targets
    if(testState == 0){candriveTarget = 100.0;}
    if(testState == 1){candriveTarget = 100.0;}
    if(testState == 2){candriveTarget = 50.0;}
    if(testState == 3){candriveTarget = 0.0;}
    if(testState == 4){candriveTarget = 100.0;}
    if(testState == 5){candriveTarget = 100.0;}
    
    // smooth
    if(candriveNetto > candriveTarget){   candriveNetto -= candriveH;  }
    if(candriveNetto < candriveTarget){   candriveNetto += 1;  }
    
    // set candrive status
    candriveAUTOsum = int(candriveNetto);
    println(candriveNetto);
    
    }
    
    if(mode == "NORMAL"){
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
    
  }
  
  void Execute_HWInput(){
  
    int[] swipeCounter = hw.getSwipeCounter();
    
    if(swipeCounter[0] > options.swipeCheckLeft){
      fsm.write("system","SETAUTO");
    }
    
    if(swipeCounter[1] > options.swipeCheckRight){
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