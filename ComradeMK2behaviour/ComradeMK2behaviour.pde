import controlP5.*;
import processing.serial.*;

ControlP5 cp5;
Slider abc;
Serial hwPort;  // The serial port


   
FSM fsm;
Display display;
LightSystem comrade;
SysInterface systeminterface;
System system;
HwInterface hw;

PFont f;

boolean hwConnected = false;

void setup(){
  size(1400,800);
  
  
  if(hwConnected){hwPort = new Serial(this, Serial.list()[0], 9600);}
  
  
  fsm = new FSM();
  display = new Display();
  comrade = new LightSystem();
  systeminterface = new SysInterface();
  system = new System();
  cp5 = new ControlP5(this);
  hw = new HwInterface();
  setP5GUI();
  noStroke();
  
  //printArray(PFont.list());
  f = createFont("Arial", 24);
  textFont(f);
  
  
}

void draw(){
  background(100);
  system.run();
  comrade.run();
  display.run();
  fsm.run();
  if(hwConnected){hw.run();}
  systeminterface.displayGui();
  graphicalElements();
}