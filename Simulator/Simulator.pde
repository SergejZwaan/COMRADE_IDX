/*

COMRADE IDX 
Autonomous Driving Experience
Simulation Software Version 2.0.

*/

/* 
Importing libraries
---------------------------------------------------------------------------------------------
*/
import controlP5.*;         // Control P5 gui elements, can be deleted if not used
import processing.opengl.*; // Open GL library for 3d rendering
import processing.serial.*; // Serial library for communication with the COMRADE IDX PROTOTYPE
import org.gamecontrolplus.gui.*;
import org.gamecontrolplus.*;
import net.java.games.input.*;
import processing.net.*;

/* 
Define objects
---------------------------------------------------------------------------------------------
*/

ControlP5 cp5;             // Control p5 elements
Grid g;                    // Create object from grid class
Camera c;                  // Create object from Camera class
PathPlanner p;             // Create object from pathplanner clasp111
Car car;                   // Create object from car clas

Connection co;             // Create object from connection class
Serial myPort;             // Create object from Serial class
GUI gui;
SystemMonitor sm;
Scenario DemoDay;
Interface comrade;

SwInterface sw;
String Server_Input;
int Server_Data;
int testState;

Client Comrade_Client;    // communication client
ControlDevice stick;      // Java input device
float px;                 // input data from the joystick
JoyStick js;              // system joystick class
ControlIO control;        // Joystick control
ControlDevice momo;       // Logitech steer
float momoSteer;
PShape carShape;          // car shape


/* 
Define variables
---------------------------------------------------------------------------------------------
*/

int gridWidth = 1600;      // size of the grid, equal to screen size to enable the path planner and scenario builder
int gridHeight = 800;
int controlState = 0;       // 

boolean autopilot = false;          // autopilot
boolean start = false;              // start (makes the car drive)
boolean firstperson = false;        // first person view
boolean startpathplanner = false;   // pathplanner
boolean manualinput = true;         // manual input
boolean serialavailable = false;     // serial device available
boolean joystickavailable = true;   // youstick variable
boolean loadpreset = true;
boolean startscreen = true;         // startscrien on
boolean pathplannerscreen = false;         // startscrien on
boolean keycontrol = true;
boolean update = false;

PShape dash;
PShape road;
PShape roadlines;

PFont f;                    // Font variable



/* 
Create program setup
---------------------------------------------------------------------------------------------
*/

void setup() {
  // window configuration
  size(1600,800,P3D);
  
   Comrade_Client = new Client(this, "127.0.0.1", 100); // Replace with your server's IP and port
   control = ControlIO.getInstance(this);// Initialise the ControlIO
   momo = control.getMatchedDevice("Wheel");// Find a device that matches the configuration file

  // initialization
  initialize_serial(serialavailable); // Initialize the serial connection 
  initialize_objects();               // Initialize the objects
  initialize_carShape();
  initialize_typo();
  if(joystickavailable){   initialize_joyStick();  }
  
   dash = loadShape("dash.svg");
   dash.rotateZ(-PI/2);
   dash.rotateX(PI/7);
   dash.scale(0.5);
   
   
   road = loadShape("road.svg");
   road.disableStyle();
   road.rotateY(PI);
   road.fill(0);
   
   
   roadlines = loadShape("lines.svg");
   roadlines.disableStyle();
   roadlines.rotateY(PI);
   roadlines.fill(255);
   noStroke();
   
   // places car standard in manual mode
   //controlState = 2;
   testState = 0;
}

void draw(){
 
  background(255);
  lights();
  
  sw.run();
  DemoDay.run();
  c.run();
  gui.run();
  g.run();
  co.run();
  p.run();
  if(joystickavailable){js.run();}
 // if( controlState == 2 && serialavailable){  car.setSteer(co.getSteerValue()); }
  if(joystickavailable){car.setSteerJoyStick(momoSteer);} 
  car.run();
  
  // manual drive
  if(controlState == 2){ comrade.Set_Manual_Drive();} 
  // autonomous drive
  if(controlState == 1){comrade.Set_Autonomous_Drive();}
}

void mouseMoved(){
  p.checkmouseMoved();
}

void keyPressed(){
if (key == 'm'){
        Comrade_Client = new Client(this, "127.0.0.1", 100); // Replace with your server's IP and port
        println("reconnect");
    }  
}