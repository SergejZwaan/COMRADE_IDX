import controlP5.*;
import processing.serial.*;
import processing.net.*;

ControlP5 cp5;
Slider abc;
Serial hwPort;  // The serial port


   
FSM fsm;
Display display;
LightSystem comrade;
SysInterface systeminterface;
System system;
HwInterface hw;
SwInterface sw;

Server Comrade_Server;
Client Comrade_Client;

String Comrade_Client_Input;
int Comrade_Client_Data[];

PFont f;

boolean hwConnected = true;

int testState = 3;

void setup(){
  size(1400,800);
  
  Comrade_Server = new Server(this, 100); // Start a simple server on a port
  if(hwConnected){hwPort = new Serial(this, Serial.list()[0], 9600);}
  
  
  fsm = new FSM();
  display = new Display();
  comrade = new LightSystem();
  systeminterface = new SysInterface();
  system = new System();
  cp5 = new ControlP5(this);
  hw = new HwInterface();
  sw = new SwInterface();
  
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
  sw.run();
  systeminterface.displayGui();
  graphicalElements();
}