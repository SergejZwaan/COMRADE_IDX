

void initialize_serial(boolean serialAvailibleSwitch) {

  if (serialAvailibleSwitch) {
    printArray(Serial.list()); 
    String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
    myPort = new Serial(this, portName, 19200);
  }
}

void initialize_objects() {

  g = new Grid();
  c = new Camera();
  p = new PathPlanner();
  car = new Car();
  
  co = new Connection();
  DemoDay = new Scenario();
  sm = new SystemMonitor();
  comrade = new Interface();
  sw = new SwInterface();
  gui = new GUI();
  if (joystickavailable) {js = new JoyStick();}
}

void initialize_carShape() {

  // configurate car shape
  carShape = loadShape("comradecar1.obj");
  carShape.scale(5);
  carShape.rotateY(PI);
  carShape.rotateX(PI/2);
}

void initialize_joyStick() {
}

void initialize_typo() {
  // startscreen font
  f = createFont("Arial", 24);        // Initialize font
  textFont(f);
}