int buttonSize = 4;
int buttonCheck = 0;
boolean[] guiCheck = new boolean[buttonSize];


void setP5GUI() {

  cp5.addButton("SetNull")
    .setValue(0)
    .setPosition(20, 320)
    .setSize(100, 100);
    
  cp5.addButton("SetIdle")
    .setValue(0)
    .setPosition(140, 320)
    .setSize(100, 100);

  cp5.addButton("SetAuto")
    .setValue(0)
    .setPosition(260, 320)
    .setSize(100, 100);
    
  cp5.addButton("SetManual")
    .setValue(0)
    .setPosition(380, 320)
    .setSize(100, 100);
    
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
    fsm.write("SETNULL");
  }
  else { buttonCheck++; }
}

public void SetIdle() {
  if (guiCheck[1]) {
    fsm.write("SETIDLE");
  }
  else { buttonCheck++; }
}

public void SetManual() {
  if (guiCheck[2]) {
    fsm.write("SETMANUAL");
  }
  else { buttonCheck++; }
}

public void SetAuto() {
  if (guiCheck[3]) {
    fsm.write("SETAUTO");
  }
  else { buttonCheck++; }
}