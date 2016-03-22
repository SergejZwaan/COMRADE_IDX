int buttonSize = 4;
int buttonCheck = 0;
int CanDrive = 100;
int Radar = 100;
int GPS = 100;
int Speed = 100;
boolean Rain , Snow, Dark = false;


boolean[] guiCheck = new boolean[buttonSize];


void setP5GUI() {

  // basic gui buttons
  // STATES
  cp5.addButton("SetNull")
    .setValue(0)
    .setPosition(20, 20)
    .setSize(100, 100);
    
  cp5.addButton("SetIdle")
    .setValue(0)
    .setPosition(140, 20)
    .setSize(100, 100);

  cp5.addButton("SetAuto")
    .setValue(0)
    .setPosition(260,20)
    .setSize(100, 100);
    
  cp5.addButton("SetManual")
    .setValue(0)
    .setPosition(380, 20)
    .setSize(100, 100);
    
  // Actions
   cp5.addButton("Stable")
    .setValue(0)
    .setPosition(20, 140)
    .setSize(100, 100);
    
  cp5.addButton("Deny")
    .setValue(0)
    .setPosition(140, 140)
    .setSize(100, 100);

  cp5.addButton("WantAuto")
    .setValue(0)
    .setPosition(260,140)
    .setSize(100, 100);
    
  cp5.addButton("WantManual")
    .setValue(0)
    .setPosition(380, 140)
    .setSize(100, 100);
    
  // set sliders
  // overall candrive slider
  cp5.addSlider("CanDrive")
     .setPosition(20,260)
     .setRange(0,100)
     .setSize(460, 50)
     ;
  
  // Scenario inputs
  // sliders
  cp5.addSlider("Radar")
     .setPosition(20,305)
     .setRange(0,100)
     .setSize(460, 25)
     ;
     
  cp5.addSlider("GPS")
     .setPosition(20,330)
     .setRange(0,100)
     .setSize(460, 25)
     ;
     
  cp5.addSlider("Speed")
     .setPosition(20,355)
     .setRange(0,100)
     .setSize(460, 25)
     ;
  
  // Scenario inputs
  // toggle
  
  cp5.addToggle("Rain")
     .setPosition(20,395)
     .setSize(100,25)
     ;
     
  cp5.addToggle("Snow")
     .setPosition(140,395)
     .setSize(100,25)
     ;
     
    cp5.addToggle("Dark")
     .setPosition(260,395)
     .setSize(100,25)
     ;
  
  for(int i = 0; i<buttonSize; i++){
    guiCheck[i] = false;
  }
  // run functions
  SetNull();
  SetIdle();
  SetManual();
  SetAuto();

  
  if((buttonCheck/2) == buttonSize){
      for(int i = 0; i<buttonSize; i++){
      guiCheck[i] = true;
    }
  }
}



public void SetNull() {
  if (guiCheck[0]) {
    fsm.write("gui","SETNULL");
  }
  else { buttonCheck++; }
}

public void SetIdle() {
  if (guiCheck[1]) {
    fsm.write("gui","SETIDLE");
  }
  else { buttonCheck++; }
}

public void SetManual() {
  if (guiCheck[2]) {
    fsm.write("gui","SETMANUAL");
  }
  else { buttonCheck++; }
}

public void SetAuto() {
  if (guiCheck[3]) {
    fsm.write("gui","SETAUTO");
  }
  else { buttonCheck++; }
}