

void initialize_serial(boolean serialAvailibleSwitch){

  if(serialAvailibleSwitch){
        printArray(Serial.list()); 
        String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
        myPort = new Serial(this, portName, 19200); 
  }

}

void initialize_objects(){

  g = new Grid();
  c = new Camera();
  p = new PathPlanner();
  car = new Car();
  startgui = new StartScreen();
  co = new Connection();
  DemoDay = new Scenario();
  sm = new SystemMonitor();
  comrade = new Interface();
  sw = new SwInterface();


}

void initJoystick(){

         // Initialise the ControlIO
  control = ControlIO.getInstance(this);
  // Find a device that matches the configuration file
  stick = control.getMatchedDevice("joystick");
  if (stick == null) {
    println("No suitable device configured");
    System.exit(-1); // End the program NOW!
  }
  

}