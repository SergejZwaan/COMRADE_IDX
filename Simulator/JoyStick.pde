class JoyStick {

  
  float gas;
  float brake;
  boolean lp;
  boolean rp;
    


  JoyStick() {

    
    if (momo == null) {
      println("No suitable device configured");
      System.exit(-1); // End the program NOW!
    }
  }

  void run() {
    momoSteer = map(momo.getSlider("W").getValue(), -1, 1,-180, 180);
    gas = map(momo.getSlider("A").getValue(),1, -1,0, 1);
    brake = momo.getSlider("B").getValue();
    
print("gas: " + gas + " - brake:  " + brake);
  }
  
  float get_Gas(){
    return gas;
  }
}