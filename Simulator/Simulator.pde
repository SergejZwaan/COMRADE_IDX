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
StartScreen startgui;      // Create object from StartScreen class, main gui
Connection co;             // Create object from connection class
Serial myPort;             // Create object from Serial class
SystemMonitor sm;
Scenario DemoDay;
Interface comrade;
<<<<<<< HEAD
SwInterface sw;

Client Comrade_Client;
ControlIO control;
ControlDevice stick;

String Server_Input;
int Server_Data;

float px;
=======
JoyStick js;


ControlIO control; // Joystick control
ControlDevice momo; // Logitech steer
>>>>>>> logitech



float momoSteer;
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
<<<<<<< HEAD
boolean joystickavailable = false;
=======
boolean joystickavailable = true;   // youstick variable
>>>>>>> logitech
boolean loadpreset = true;

boolean startscreen = true;         // startscrien on
boolean pathplannerscreen = false;         // startscrien on
boolean keycontrol = true;
boolean update = false;

PFont f;                    // Font variable


/* 
Create program setup
---------------------------------------------------------------------------------------------
*/

void setup() {
  // window configuration
  size(1600,800,P3D);
<<<<<<< HEAD
  Comrade_Client = new Client(this, "127.0.0.1", 100); // Replace with your server's IP and port
=======
   control = ControlIO.getInstance(this);// Initialise the ControlIO
   momo = control.getMatchedDevice("Wheel");// Find a device that matches the configuration file
>>>>>>> logitech
  // initialization
  initialize_serial(serialavailable); // Initialize the serial connection 
  initialize_objects();               // Initialize the objects
  initialize_carShape();
  initialize_typo();
  if(joystickavailable){   initialize_joyStick();  }
 
}

void draw(){
  background(255);
  lights();
  
  if(startscreen){  startgui.run();  }
<<<<<<< HEAD
  sw.run();
=======
>>>>>>> logitech
  DemoDay.run();
  c.run();
  gui();
  g.run();
  co.run();
  p.run();
  js.run();
  //sm.run(co.getSteerValue());// system monitor
  
  if( controlState == 2 && serialavailable){  car.setSteer(co.getSteerValue());  }
  //car.setSteer(co.getSteerValue());
  if( joystickavailable){car.setSteerJoyStick(momoSteer);}
  car.run();
  
  // manual drive
  if(controlState == 2){
      comrade.Set_Manual_Drive();
  } 
  
  // autonomous drive
  if(controlState == 1){
     comrade.Set_Autonomous_Drive(); 
  }
  
  if( joystickavailable){
  getUserInput(); // Polling
  println(momoSteer);
  }
  
  
}

void mouseMoved(){
  p.checkmouseMoved();
}

//TODO has to be made graphical
public void getUserInput() {
  
}