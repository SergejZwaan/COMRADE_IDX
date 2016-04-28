// public variables interface

int buttonSize = 6;
int buttonCheck = 0;
int CanDrive = 100;
int Radar = 100;
int GPS = 100;
int Speed = 100;
boolean Rain , Snow, Dark = false;
boolean Platoon , AHWay, Manouvre = false;
boolean leftHand = true;

String hwInput;

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


  cp5.addButton("s0")
    .setValue(0)
    .setPosition(600, 20)
    .setSize(100, 100);
    
    cp5.addButton("s1")
    .setValue(0)
    .setPosition(700, 20)
    .setSize(100, 100);
    
      cp5.addButton("s2")
    .setValue(0)
    .setPosition(800, 20)
    .setSize(100, 100);
    
      cp5.addButton("s3")
    .setValue(0)
    .setPosition(900, 20)
    .setSize(100, 100);
    
      cp5.addButton("s4")
    .setValue(0)
    .setPosition(1000, 20)
    .setSize(100, 100);
    
      cp5.addButton("s5")
    .setValue(0)
    .setPosition(1100, 20)
    .setSize(100, 100);
    
  






  
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
     
   cp5.addToggle("Platoon")
     .setPosition(20,435)
     .setSize(100,25)
     ;
     
  cp5.addToggle("AHWay")
     .setPosition(140,435)
     .setSize(100,25)
     ;
     
  cp5.addToggle("Manouvre")
     .setPosition(260,435)
     .setSize(100,25)
     ;
  
  cp5.addToggle("leftHand")
     .setPosition(20,535)
     .setSize(100,25)
     ;
     
  cp5.addToggle("rightHand")
     .setPosition(140,535)
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
  WantAuto();
  WantManual();

  
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

public void WantAuto() {
  if (guiCheck[4]) {
    fsm.write("gui","SETWANTAUTO");
    
  }
  else { buttonCheck++; }
}

public void WantManual() {
  if (guiCheck[5]) {
    fsm.write("gui","SETWANTMANUAL");
    
  }
  else { buttonCheck++; }
}

public void s0() {testState=0;}
public void s1() {testState=1;}
public void s2() {testState=2;}
public void s3() {testState=3;}
public void s4() {testState=4;}
public void s5() {testState=5;}

void graphicalElements(){

  graphicalTextElements();
  graphicalCapElements();
  
  
}

void graphicalTextElements(){
  //text
  fill(255);
  text("Can drive = " + system.getDriveAutoSum() , 40, 280);
  
 
 
  text("Arduino input = " + hwInput , 40,680,400,30);
  
  int[] swipeCounter = hw.getSwipeCounter();
  
  text("Swipe Left = " + swipeCounter[0] , 40,750,300,30);
  text("Swipe Right = " + swipeCounter[1] , 240,750,300,30);
}

void graphicalCapElements(){
  boolean[] capsense = hw.getCap();
  
  pushMatrix();
  translate(775,500);
  int pos = 0;
  for(int i = capsense.length-1; i > -1 ; i--){
    if(capsense[i]){fill(255);}
    else if(!capsense[i]){fill(0);}
    rect(0 + 50 * pos ,0,30,100);
    pos++;
  }
  
  PVector location = hw.getLocation();
  fill(255);
  ellipse(location.x, -20,10,10);
  
  
  popMatrix();


}