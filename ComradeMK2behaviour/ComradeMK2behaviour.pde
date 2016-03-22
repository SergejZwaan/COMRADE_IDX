import controlP5.*;

ControlP5 cp5;
Slider abc;
   
FSM fsm;
Display display;
LightSystem comrade;
SysInterface systeminterface;
System system;

void setup(){
  size(1400,800);
  
  fsm = new FSM();
  display = new Display();
  comrade = new LightSystem();
  systeminterface = new SysInterface();
  system = new System();
  cp5 = new ControlP5(this);
  setP5GUI();
  noStroke();
  
  
}

void draw(){
  background(100);
  system.run();
  
  comrade.run();
  display.run();
  fsm.run();
  systeminterface.displayGui();
}