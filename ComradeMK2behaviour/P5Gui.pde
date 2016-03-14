void setP5GUI(){
      
  cp5.addButton("Auto")
             .setValue(0)
             .setPosition(20,320)
             .setSize(100,100);
  
    cp5.addButton("Manual")
             .setValue(0)
             .setPosition(120,320)
             .setSize(100,100);

}

public void Auto(){
  fsm.write("SETAUTO");
}

public void Manual(){
  fsm.write("SETMANUAL");
}