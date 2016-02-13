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
boolean serialavailable = false;     // serial device available
boolean loadpreset = true;

boolean startscreen = true;         // startscrien on
boolean pathplannerscreen = false;         // startscrien on

PFont f;                    // Font variable


/* 
Create program setup
---------------------------------------------------------------------------------------------
*/

void setup() {
  size(1600,800,P3D);
  
  initialize_serial(serialavailable); // Initialize the serial connection 
  initialize_objects();               // Initialize the objects

  f = createFont("Arial", 24);        // Initialize font
  textFont(f);
  
  carShape = loadShape("comradecar1.obj");
  carShape.scale(5);
 carShape.rotateY(PI);
  carShape.rotateX(PI/2);
  
  //carShape.rotateZ(PI/2);
  //carShape.scale(1);
  
  // start automatically in autonomous driving mode
  controlState = 1;
  
}

void draw(){
  background(255);
  lights();
  if(startscreen){
      startgui.run();
  }
  
  
  DemoDay.run();
  c.run();
  gui();
  g.run();
  co.run();
  p.run();
  
  sm.run(co.getSteerValue());// system monitor
  
  if( autopilot == false && manualinput == true && serialavailable){car.setSteer(co.getSteerValue());}
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
void gui(){
  
  if (keyPressed) {
    if (key == ENTER && autopilot == false) {
      autopilot = true;
      println("start autopilot");
    } if (key == 's'){
      if( start == false){
      car.setDriveStatus(true);
      println("start car");
      }
      else{
      car.setDriveStatus(false);
      println("stop car");
      }
    }if (key == 'q'){
     firstperson = true;
     
     startscreen = false;
     pathplannerscreen = false;
    } if (key == 'w'){
      firstperson = false;
      //endCamera();
    }if (key == 'x' && startscreen == false) {
      println("shift");
       autopilot = false;
       start = false;
       firstperson = false;
       startscreen = true;
       startpathplanner = false;
    } if (key == 'o'){
      // set autopilot false
      // set manual drive true
      autopilot = false;
      manualinput = true;
      //car.applyForce(new PVector(0,0));
      car.resetTheta();
      startpathplanner = false;
      controlState = 2;
    }if (key == 'p'){
      // set autopilot true
      // set manual drive false
      
    }
    
    
     // Controlling the comrade
     // Serial commands
     
    if(serialavailable){
          if (key == '0') {
            myPort.write ('0');
            //println("check");
          }
          if (key == '1') {
            myPort.write ('1');
          }
          if (key == '2') {
            myPort.write ('2');
          }
          if (key == '3') {
            myPort.write ('3');
          }
          if (key == '4') {
            myPort.write ('4');
          }
          if (key == '5') {
            myPort.write ('5');
          }
    }
  }
  
  
 

}