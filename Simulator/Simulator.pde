/*

COMRADE IDX 
Inteligent Driving Experience
Simulation Software Version 1.0.

Compatible with the COMRADE IDX Mark 1 prototype.
*/

// github compatible

/* 
Importing libraries
---------------------------------------------------------------------------------------------
*/
import controlP5.*;         // Control P5 gui elements, can be deleted if not used
import processing.opengl.*; // Open GL library for 3d rendering
import processing.serial.*; // Serial library for communication with the COMRADE IDX PROTOTYPE

/* 
Define objects
---------------------------------------------------------------------------------------------
*/

ControlP5 cp5;             // Control p5 elements
Grid g;                    // Create object from grid class
Camera c;                  // Create object from Camera class
PathPlanner p;             // Create object from pathplanner clasp111
Car car;                   // Create object from car clas
StartScreen startgui;      // Create object from StartScreen class, main gui
Connection co;             // Create object from connection class
Serial myPort;             // Create object from Serial class
SystemMonitor sm;
Scenario DemoDay;
Interface comrade;

PShape carShape;


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
boolean serialavailable = true;     // serial device available
boolean loadpreset = true;

boolean startscreen = true;         // startscrien on
boolean pathplannerscreen = false;         // startscrien on
boolean keycontrol = false;

PFont f;                    // Font variable


/* 
Create program setup
---------------------------------------------------------------------------------------------
*/

void setup() {
  size(1600,800,P3D);
  
  // initialization
  initialize_serial(serialavailable); // Initialize the serial connection 
  initialize_objects();               // Initialize the objects

  // startscreen font
  f = createFont("Arial", 24);        // Initialize font
  textFont(f);
  
  // configurate car shape
  carShape = loadShape("comradecar1.obj");
  carShape.scale(5);
  carShape.rotateY(PI);
  carShape.rotateX(PI/2);

  
}

void draw(){
  background(255);
  lights();
  
  if(startscreen){  startgui.run();  }
  
  
  DemoDay.run();
  c.run();
  gui();
  g.run();
  co.run();
  p.run();
  
  sm.run(co.getSteerValue());// system monitor
  
  //if( controlState == 2 && serialavailable){  car.setSteer(co.getSteerValue());  }
  car.setSteer(co.getSteerValue());
  car.run();
  
  // manual drive
  if(controlState == 2){
      comrade.Set_Manual_Drive();
  } 
  
  // autonomous drive
  if(controlState == 1){
     comrade.Set_Autonomous_Drive(); 
  }
}

void mouseMoved(){
  p.checkmouseMoved();
}

//TODO has to be made graphical