class System{

  private int candrivesum;
  
  System(){
    
  }
  
  void run(){
    Analyze_CanDrive();
  }
  
  void Analyze_CanDrive(){
    candrivesum = 0;
    candrivesum += Radar/2;
    candrivesum += GPS/2;
    CanDrive = candrivesum;  
    
  }
  
  boolean CanDriveAutonomous(){
    if(candrivesum >= 75){return true;}
    else{return false;}
  }
  
  boolean CanDriveManual(){
    return true;
  }







}