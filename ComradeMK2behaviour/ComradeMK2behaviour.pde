import controlP5.*;

ControlP5 cp5;
       
FSM fsm;
Display display;
LightSystem comrade;
SysInterface systeminterface;

void setup(){
  size(600,600);
  cp5 = new ControlP5(this);
  fsm = new FSM();
  display = new Display();
  comrade = new LightSystem();
  systeminterface = new SysInterface();
  setP5GUI();
  noStroke();
  

}

void draw(){
  background(100);
  comrade.run();
  display.run();
  fsm.run();
  systeminterface.displayGui();
}