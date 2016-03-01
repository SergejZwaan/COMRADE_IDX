import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 
import processing.opengl.*; 
import processing.serial.*; 
import org.gamecontrolplus.gui.*; 
import org.gamecontrolplus.*; 
import net.java.games.input.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Simulator extends PApplet {

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
         // Control P5 gui elements, can be deleted if not used
 // Open GL library for 3d rendering
 // Serial library for communication with the COMRADE IDX PROTOTYPE





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


ControlIO control;
ControlDevice stick;
float px;



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
boolean joystickavailable = false;
boolean loadpreset = true;

boolean startscreen = true;         // startscrien on
boolean pathplannerscreen = false;         // startscrien on
boolean keycontrol = false;
boolean update = false;

PFont f;                    // Font variable


/* 
Create program setup
---------------------------------------------------------------------------------------------
*/

public void setup() {
  
  
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

public void draw(){
  background(255);
  lights();
  
  if(startscreen){  startgui.run();  }
  
  DemoDay.run();
  c.run();
  gui();
  g.run();
  co.run();
  p.run();
  
  //sm.run(co.getSteerValue());// system monitor
  
  if( controlState == 2 && serialavailable){  car.setSteer(co.getSteerValue());  }
  //car.setSteer(co.getSteerValue());
  if( joystickavailable){car.setSteerJoyStick(px);}
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
  println(px);
  }
  
}

public void mouseMoved(){
  p.checkmouseMoved();
}

//TODO has to be made graphical

public void getUserInput() {
  px = map(stick.getSlider("X").getValue(), -1, 1,-180, 180);
}
class Camera{

 // PVector[] camSnake = new PVector[10];
  
  Camera(){

   
    
  }
  
  public void run(){
  
     if(firstperson == true){first_Person();}
     if(firstperson == false){top_View();}
    
  }
  
  public void first_Person(){
    PVector eye = car.getLocation().copy();
    PVector camerapoint = car.getCameraLocation().copy();
    camera( camerapoint.x, camerapoint.y, -40, eye.x, eye.y, -40, 0, 0, 1);
  
  }
  
  public void top_View(){
    camera( gridWidth/2, gridHeight/2, 690, gridWidth/2, gridHeight/2, 0, 0, 1, 0);
  }
  

}
class Car{

  PVector location;
  PVector velocity;
  PVector force;
  float theta = 0;
  float angle = PI/2;
  
  float xold = gridWidth/2;
  float yold = gridHeight/2+100;
  float distx = gridWidth/2;
  float disty = gridHeight/2+100;
  float cameraX, cameraY;
  float speed = 0.5f;
  
  // acceleration variables
  float acceleration = 0.005f;
  float nettospeed = 0.0f;
  
  
  boolean drive = false;
  
  Car(){
    location = new PVector(gridWidth/2,gridHeight/2+200);
    velocity = new PVector(0,0);
    velocity = new PVector(0,-0.1f);
    force = new PVector(0,0);
    xold = location.x;
    yold = location.y;
  }
  
  
  public void update(){
    
    // speed manager
    speedControl();
   
    // update code
    if(drive == true){
     
        if(autopilot == true){
          velocity.add(force);
        }
      
      velocity.rotate(theta);
      velocity.setMag(nettospeed);
     if(drive){ location.add(velocity);}
      else{location.add(new PVector(0.0f,0.0f));}
      
      distx = location.x - (location.x - xold)*50;
      disty = location.y - (location.y - yold)*50;
      cameraX = location.x - (location.x - xold)*70 /car.getNettoSpeed();
      cameraY = location.y - (location.y - yold)*70 /car.getNettoSpeed();
      xold = location.x;
      yold = location.y;
      
      angle = atan2(location.y-disty, location.x-distx);
      
     // println(force);
    //println(velocity.y);
    }else if(drive == false){
      //velocity = new PVector(0.0,0.0);
    }
    
     
      
  }
  
  public void speedControl(){
  
      if(nettospeed < speed){
        nettospeed += acceleration;
      } else if(nettospeed> speed){
        nettospeed -= acceleration;
      }
  
  
  }
  
  public void display(){

    pushMatrix();
      translate(location.x,location.y,-5);
      rotate(angle);
     // rotate(theta);
      strokeWeight(1);
      fill(255);
      stroke(0);
      rotate(PI);
   
      translate(-30, -10,0);
      shape(carShape,10,10);
    popMatrix();
    
    
  }
  
  public void run(){
    keyPressed();
    keyReleased();
    if(drive && update){update();}
    display();
  }
  
  
 // key controll
public void keyPressed() {
  if (key == CODED) {
        if (keyCode == UP) {
          drive = true;
        } else if (keyCode == DOWN) {
          theta = 0.0f;
        }  else if (keyCode == LEFT){
          theta = HALF_PI/180/2;
        } else if(keyCode == RIGHT){
          theta = -HALF_PI/180/2;
        } else{
          theta = 0.0f;
        }
  }

}

public void setSteer(int input){
  float steerValueInput = map(input,700,1024,-HALF_PI,HALF_PI);
  theta = -steerValueInput/270;
  //println(theta);
}

public void setSteerJoyStick(float input){
  float steerValueInput = input/100;
  theta = -steerValueInput/270;
  print(" " + theta + " ");
}

public void resetTheta(){
  theta = 0.0f;
}

public void keyReleased(){
 // theta = 0;
}

public PVector getLocation(){
  return location;
}

public PVector getCameraLocation(){
  PVector cameraLocation = new PVector(cameraX, cameraY);
  return cameraLocation;
}

public void applyForce(PVector inforce){
  force = inforce;
}

public boolean getDriveStatus(){
  return drive;
}

public void setDriveStatus(boolean drivestatus){
    drive = drivestatus;
}

public void setSpeed(float input){
    speed = input;
}

public float getTheta(){
    return theta;
}

public float getSpeed(){
  return speed;
}

public float getNettoSpeed(){
  return nettospeed;
}


}
class Connection{
  
  String message = "empty";
  String steervalue = "empty";
  String control;
  
  
  Connection(){
  
  
  }
  
  
  public void run(){
  
      if ( serialavailable && myPort.available() > 0 ) 
      {  // If data is available,
      message = myPort.readStringUntil('n');         // read it and store it in val
      
      
        //println(message);
        if(message != null && message.length() > 5){
        String initial = message.substring(2,7);
       
        //println(initial);
          if( initial.equals("start")){
          
           steervalue = message.substring(7,message.indexOf('b'));
           control = message.substring(message.indexOf('b')+1,message.indexOf('/'));
          
          
          controlState = PApplet.parseInt(control);
          }
        }
     
      }
      
  
  }

  public int getSteerValue(){
    int val = PApplet.parseInt(steervalue);
    return val;
  
  }
  
  

}
class Grid{

  Grid(){
  
  }
  
  public void run(){
    fill(30);
    rect(0,0,gridWidth,gridHeight);
    pushMatrix();
    translate(0,0,-0.5f);
    fill(255);
    stroke(255);
    for(int i= 0; i<10;i++){
      for(int j = 0; j<10;j++){
        ellipse(i * (gridWidth/10) + (gridWidth/20), j * (gridHeight /10) + (gridWidth/30), 3,3);
       // point(i,j);
      }
    //draw_Road();
    }
    popMatrix();
  }
  
  public void draw_Road(){
  
    fill(30);
    beginShape();
      int outerdistance = 100;
      int innerdistance = 200;
      //outersquare
      line(outerdistance,outerdistance,outerdistance,gridHeight-outerdistance);
      line(outerdistance,gridHeight-outerdistance,gridWidth-outerdistance,gridHeight-outerdistance);
      line(gridWidth-outerdistance,gridHeight-outerdistance,gridWidth-outerdistance,outerdistance);
      line(gridWidth-outerdistance,outerdistance,outerdistance+1,outerdistance);
      
      line(innerdistance,innerdistance,innerdistance,gridHeight-innerdistance);
      line(innerdistance,gridHeight-innerdistance,gridWidth-innerdistance,gridHeight-innerdistance);
      line(gridWidth-innerdistance,gridHeight-innerdistance,gridWidth-innerdistance,innerdistance);
      line(gridWidth-innerdistance,innerdistance,innerdistance+1,innerdistance);
      
      line(outerdistance,outerdistance,innerdistance,innerdistance);
      line(innerdistance+1,innerdistance,outerdistance+1,outerdistance);
    endShape();
  
  }



}
class Interface{

  Interface(){
  
  }
  
  public void Set_Manual_Drive(){
      autopilot = false;
      manualinput = true;
      car.applyForce(new PVector(0,0));
      p.resetPathPlanner();
      startpathplanner = false;
  
  }
  
  public void Set_Autonomous_Drive(){
      manualinput = false;
      car.resetTheta();
      autopilot = true;
      p.startAutonomousDriving(autopilot);
      startpathplanner = true;
      controlState = 1;
  }




}

public void gui(){
  
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
      
    }if (key == 'z'){
      update = true;
      
    }if (key == 'a'){
      update = false;
    }
    
    
     // Controlling the comrade
     // Serial commands
     
    if(serialavailable && keycontrol){
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
class PathPlanner{
  
   
   boolean listfull = false; // if list is full
   boolean listcreated = false; // if list is created
   boolean mousePres = false;
   
   
   boolean autonomousdrive = false; // autonomous drive switch state
   
   boolean find_closest_checkpoint = false;
   boolean autonomous_driving_running = false; // if autonomous driving is running
   
   int identity = 0;
   int focusCheckPoint = 0;
   int pointnumbers = 40;
   
   PVector force;
   
   int[] xcor = {783,781,766,747,715,661,514,379,300,232,185,157,140,132,132,132,138,151,171,196,299,603,871,1079,1283,1374,1433,1469,1497,1505,1505,1495,1453,1383,1287,916,865,820,797,785};
   int[] ycor = {362,211,180,155,137,134,130,128,128,126,137,158,185,219,251,288,321,349,374,384,383,383,383,383,385,386,397,421,458,494,560,623,675,701,702,701,689,667,634,601};
   
   int xcounter = 0;
   int ycounter = 0;
   
   // array list of point objects
   ArrayList<PathPlannerPoint> ppp;
   
   
   
   PathPlanner(){
       // create new array list
       ppp = new ArrayList<PathPlannerPoint>();
       
       // if load preset is true
       if(loadpreset){
         loadPreset(); // fil arraylist
         listcreated = true;
         listfull = true;
       }
   
   }
   
   public void run(){
     if(startpathplanner ){ 
       drawCursor();
       update();
       displayArray();
       findNearestCheckpoint();
       checkCheckPointSwitch();
       if(autopilot){
       calculateForce(focusCheckPoint);}
      // mouseMoved();
       }
     }
     
     public void drawCursor(){
       // draw cursor
       if(firstperson == false){
         pushMatrix();
             translate(0,0,4);
             fill(60);
             stroke(255);
             ellipse(mouseX,mouseY,10,10);
             line(mouseX,0,mouseX,gridHeight);
             line(0,mouseY,gridWidth,mouseY);
          popMatrix();
       }
     }

     public void update(){
         if(mousePressed && listfull == false  && mousePres == false && (mouseButton == RIGHT)){
           ppp.add(new PathPlannerPoint(mouseX,mouseY, identity));
           identity++;
           xcor[xcounter] = mouseX;
           ycor[ycounter] = mouseY;
           
           xcounter++;
           ycounter++;
           
           print("{");
           for(int i = 0; i < 40; i++){
           print(xcor[i] + ",");
           }
           println("}");
           
           print("{");
           for(int i = 0; i < 40; i++){
           print(ycor[i] + ",");
           }
           println("}");
           
           
           
           
           listcreated = true;
           mousePres = true;
         }
         
         if(ppp.size() > pointnumbers){
           listfull = true;
         }
     }
     
     public void displayArray(){
         for( int i = 0; i < ppp.size(); i++){
           PathPlannerPoint p = ppp.get(i);
             PVector LocationFormerPoint = new PVector();
             PVector locationPoint = p.getLocation();
             
             // if i == 0, get the location from the last point in the array
             // this connects all the dots
             if(i == 0){
                 PathPlannerPoint f = ppp.get(ppp.size()-1);
                 LocationFormerPoint = f.getLocation();
             } else{
                 PathPlannerPoint f = ppp.get(i-1);
                 LocationFormerPoint = f.getLocation();
             }
             
             pushMatrix();
                   strokeWeight(1);
                   line(locationPoint.x,locationPoint.y,LocationFormerPoint.x,LocationFormerPoint.y);
                   translate(0,0,-4);
                   strokeWeight(4);
                   stroke(0,200,200);
                   line(locationPoint.x,locationPoint.y,LocationFormerPoint.x,LocationFormerPoint.y);
                   stroke(255);
                   strokeWeight(1);
             popMatrix();
            
           
           p.display();
           
         }
     }
     
     public void findNearestCheckpoint(){
       if( autonomousdrive == true &&
           find_closest_checkpoint == false &&
           autonomous_driving_running == false){
                   
                   PVector carloc = car.getLocation().copy();
                   int idx_closest = 0;
                   float closest_dist = gridHeight;
                   for( int i = 0; i < ppp.size();i++){
                     PathPlannerPoint p = ppp.get(i);
                     PVector pointloc = p.getLocation().copy();
                     float d = PVector.dist(carloc, pointloc);
                     if(d < closest_dist){
                       idx_closest = i;
                       closest_dist = d;
                     }
                   }
                   
                  //println(idx_closest + " " + closest_dist);
                  find_closest_checkpoint = true;
                  // always go to the next point
                  if(idx_closest < 39){
                  focusCheckPoint = idx_closest + 1;
                  }
                  autonomous_driving_running = true;
           }
     }
     
     public void checkCheckPointSwitch(){
          
       
       if(listcreated == true && 
           car.getDriveStatus() == true &&
           autonomousdrive == true &&
           find_closest_checkpoint == true //&&
           //autonomous_driving_running == false
           ){
          
       
          PVector carloc = car.getLocation().copy();
          PathPlannerPoint p = ppp.get(focusCheckPoint);
          PVector pointloc = p.getLocation().copy();
          float distance = PVector.dist(carloc,pointloc);
          if(distance < 30 ){
          focusCheckPoint++;
          if(focusCheckPoint >= ppp.size()){
             focusCheckPoint = 0;
          }
          }
        }
     }
     
     public void calculateForce(int idx_checkpoint){
        if(listcreated == true && 
           car.getDriveStatus() == true &&
           autonomousdrive == true &&
           find_closest_checkpoint == true //&&
           //autonomous_driving_running == false
           ){
          PVector carloc = car.getLocation().copy();
          PathPlannerPoint p = ppp.get(idx_checkpoint);
          PVector pointloc = p.getLocation().copy();
          PVector force = pointloc.sub(carloc);
        
          force.normalize();
          force.setMag(0.01f);
        //  carloc.mult(0.1);
          
          car.applyForce(force);
        }
     
     }
     
     public void checkmouseMoved(){
       mousePres = false;
     }
     
     public void startAutonomousDriving(boolean status){
       autonomousdrive = status;
     }
     
     public void resetPathPlanner(){
         autonomousdrive = false;
   
        find_closest_checkpoint = false;
        autonomous_driving_running = false;
     
     }
     
     public void loadPreset(){
       
       for(int i = 0; i<40; i++){
         ppp.add(new PathPlannerPoint(xcor[i],ycor[i], i));
         //println("add new p" + i);
       }
       
     }





}
class PathPlannerPoint{

  PVector location;
  int id;
  float pointSize = 5.0f;
  
  PathPlannerPoint(float x, float y, int i){
    id = i;
    location = new PVector(x,y);
  }
  
  public void display(){
    pushMatrix();
      fill(0,50,50);
      translate(0,0,-2);
      ellipse(location.x,location.y,pointSize,pointSize);
      translate(0,0,2);
      ellipse(location.x,location.y,pointSize,pointSize);
      translate(0,0,-1);
    popMatrix();
  }
  
  public PVector getLocation(){
    return location;
  }
}
class Scenario{

  PVector carlocation;
  boolean sendswitch;
  
  Scenario(){
    
   sendswitch = false;
    
  }
  
  public void run(){
    carlocation = car.getLocation().copy();
    
    if(firstperson){
    draw_road();
    pushMatrix();
    translate(0,0,5);
    draw_road();
    draw_buildings();
    scenario1();
    popMatrix();
    }
    
  }
  
  // draw the road visual
  public void draw_road(){
  
      pushMatrix();
                translate(0,0,-1.1f);
                int margin = 75;
                fill(60);
                
                // roads
                strokeWeight(0);
                rect(margin,margin,(gridWidth/2)-margin,margin);                  // rect 1
                rect(margin,margin,margin,(gridHeight/2)-margin);                 // rect 2
                rect(margin,(gridHeight/2)-margin/2,(gridWidth)-margin*2,margin);  // rect 3
                rect((gridWidth)-margin*2,(gridHeight/2),margin,(gridHeight/2)-margin);   // rect 4
                rect((gridWidth/2),gridHeight-margin*2,(gridWidth/2)-margin,margin);      // rect 5
                
                rect((gridWidth/2)-margin/2,margin,margin,gridHeight-margin*2);                 // rect 6
                
                strokeWeight(1);
                // upper left
               
                // corners outer
                fill(60);
                arc(margin*2+margin, margin*2+margin, margin*4, margin*4, PI, PI+HALF_PI);
                arc(margin*2+margin, gridHeight/2-margin/2-margin, margin*4, margin*4, HALF_PI, PI);
                arc( (gridWidth/2)-margin/2+margin*2, gridHeight-margin*2-margin, margin*4, margin*4,  HALF_PI, PI);
                arc((gridWidth/2)-margin/2-margin, margin*2+margin, margin*4, margin*4, PI+HALF_PI, TWO_PI);
                arc( gridWidth - margin*2-margin, gridHeight/2-margin/2+margin*2, margin*4, margin*4,  PI+HALF_PI, TWO_PI);
                arc( gridWidth - margin*2-margin, gridHeight-margin*2-margin, margin*4, margin*4, 0, HALF_PI);
          
                    translate(0,0,-1);
                    fill(30);
                    arc(margin*2+margin, margin*2+margin, margin*2, margin*2, PI, PI+HALF_PI);
                    arc(margin*2+margin, gridHeight/2-margin/2-margin, margin*2, margin*2, HALF_PI, PI);
                    arc( (gridWidth/2)-margin/2+margin*2, gridHeight-margin*2-margin, margin*2, margin*2, HALF_PI, PI);
                    arc((gridWidth/2)-margin/2-margin, margin*2+margin, margin*2, margin*2, PI+HALF_PI, TWO_PI);
                    arc( gridWidth - margin*2-margin, gridHeight/2-margin/2+margin*2, margin*2, margin*2,  PI+HALF_PI, TWO_PI);
                    arc( gridWidth - margin*2-margin, gridHeight-margin*2-margin, margin*2, margin*2, 0, HALF_PI);
                    
                    // path planner screen visual
                    translate(0,0,1);
                    fill(30);
                    arc(margin*2+margin, margin*2+margin, margin*2, margin*2, PI, PI+HALF_PI);
                    arc(margin*2+margin, gridHeight/2-margin/2-margin, margin*2, margin*2, HALF_PI, PI);
                    arc( (gridWidth/2)-margin/2+margin*2, gridHeight-margin*2-margin, margin*2, margin*2, HALF_PI, PI);
                    arc((gridWidth/2)-margin/2-margin, margin*2+margin, margin*2, margin*2, PI+HALF_PI, TWO_PI);
                    arc( gridWidth - margin*2-margin, gridHeight/2-margin/2+margin*2, margin*2, margin*2,  PI+HALF_PI, TWO_PI);
                    arc( gridWidth - margin*2-margin, gridHeight-margin*2-margin, margin*2, margin*2, 0, HALF_PI);
      popMatrix();
  }
  
  public void draw_buildings(){
  
        for( int i = 0; i <6; i++){
        pushMatrix();
        translate(250 + i*220,250,-150);
        fill(255);
        box(120,80,350);
        popMatrix();
        }
        
        for( int i = 0; i <6; i++){
        pushMatrix();
        translate(250 + i*220,550,-150);
        fill(255);
        box(80,120,350);
        popMatrix();
        }
        
        // top
        
        for( int i = 0; i <6; i++){
        pushMatrix();
        translate(200 + i*240,0,-150);
        fill(255);
        box(200,80,350);
        popMatrix();
        }
        
        // bottom
        
        for( int i = 0; i <6; i++){
        pushMatrix();
        translate(200 + i*240,gridHeight,-150);
        fill(255);
        box(200,80,350);
        popMatrix();
        }
  }
  
  public void scenario1(){
    int margin = 75;
    // scenario 1 visuals
    pushMatrix();
    // TODO fix this
    if(!firstperson && pathplannerscreen){ translate(0,0,1); }
    if(firstperson){ translate(0,0,-10); }
    
   
    fill(0,0,255);
    rect(580,75,20,80); // area 1
    rect(220,75,20,80); // area 2
   
   rect((gridWidth/2)+margin,gridHeight-margin*2,(gridWidth/3),margin);      // rect 4
    
    fill(30);
    stroke(255);
    rect(240,(gridHeight/2)-margin/2,gridWidth/2,margin); // area 3
    
      
        pushMatrix();
        translate(280,130,-5);
        fill(255);
        box(20);
        popMatrix();
        
        pushMatrix();
        translate((gridWidth/2)+margin*2,gridHeight-margin*2,-5);
        fill(255);
        box(20);
        popMatrix();
        
        pushMatrix();
        translate((gridWidth/2)+margin*4,gridHeight-margin*2,-5);
        fill(255);
        box(20);
        popMatrix();
        
        pushMatrix();
        translate((gridWidth/2)+margin*6,gridHeight-margin*2,-5);
        fill(255);
        box(20);
        popMatrix();
        
        
        
    popMatrix();
    
    // area 1
    if(carlocation.x >580 && carlocation.x <600 && carlocation.y >75 && carlocation.y< 155){
      
                    if(controlState == 1){
                    car.setDriveStatus(false);
                    update = false;
                    }
                    if(controlState == 2){
                    car.setDriveStatus(true);
                    update = true;
                    }
                    
                    if(sendswitch == false && controlState == 1 && serialavailable){
                    myPort.write ('3');
                    sendswitch = true;
      }
      
    // area 2
    }else if(carlocation.x >220 && carlocation.x <240 && carlocation.y >75 && carlocation.y< 155){
            
               if(sendswitch == false && controlState == 2 && serialavailable){
                    myPort.write ('4');
                    sendswitch = true;}

    }else if(carlocation.x > 240 && carlocation.x < 240 + gridWidth/2 && carlocation.y >(gridHeight/2)-(margin/2) && carlocation.y < (gridHeight/2)-(margin/2) + margin ){
            
              //println("test3");
              car.setSpeed(2.0f);
    
    }else if(carlocation.x > (gridWidth/2)+margin && carlocation.x < (gridWidth/2)+margin + (gridWidth/3) && carlocation.y >gridHeight-margin*2 && carlocation.y < gridHeight-margin*2 + margin ){
              //println("area 4");
              if(sendswitch == false && controlState == 1 && serialavailable){
                    println("run area 4");
                    myPort.write ('5');
                    sendswitch = true;
                    car.setSpeed(0.3f);
                  }
              
    
    }else{
        sendswitch = false;
        car.setSpeed(0.5f);
    }
  }

}


public void initialize_serial(boolean serialAvailibleSwitch){

  if(serialAvailibleSwitch){
        printArray(Serial.list()); 
        String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
        myPort = new Serial(this, portName, 19200); 
  }

}

public void initialize_objects(){

  g = new Grid();
  c = new Camera();
  p = new PathPlanner();
  car = new Car();
  startgui = new StartScreen();
  co = new Connection();
  DemoDay = new Scenario();
  sm = new SystemMonitor();
  comrade = new Interface();



}

public void initJoystick(){

         // Initialise the ControlIO
  control = ControlIO.getInstance(this);
  // Find a device that matches the configuration file
  stick = control.getMatchedDevice("joystick");
  if (stick == null) {
    println("No suitable device configured");
    System.exit(-1); // End the program NOW!
  }
  

}
class StartScreen{

  // Initialize
  StartScreen(){
  }

  // RUN ALL THE FUNCTIONS
  public void run(){
  
      pushMatrix();
      translate(0,0,5);
      draw_screen();
      translate(-100,0,0);
      draw_configButton((width/5),height/2-100,200,200);
      draw_RunSimulationButton((width/5)*2,height/2-100,200,200);
      draw_PathPlannerButton((width/5)*3,height/2-100,200,200);
      draw_ScenarioPlannerButton((width/5)*4,height/2-100,200,200);
      popMatrix();
  
  }
  
  public void draw_screen(){
    
      fill(30);
      rect(0,0,width,height);
  }
  
  
  
  public void draw_RunSimulationButton(int x, int y, int w, int h){
  
    fill(255);
    rect(x,y,w,h);
    fill(0);
    text("Simulator", x+10, y+20);
    
     if (mousePressed == true ) {
       if(mouseX < (x+w) && mouseX > x){
         if(mouseY < ( y+w) && mouseY > y){
            // code for mousepressed 
           println("button run simulator pressed");
           startscreen = false;
           firstperson = true;
           
           pathplannerscreen = false;
           
            }
         }
      }
  
  
  }
  
  
    public void draw_PathPlannerButton(int x, int y, int w, int h){
  
        fill(255);
        rect(x,y,w,h);
        fill(0);
        text("PathPlanner", x+10, y+20);
        
         if (mousePressed == true ) {
           if(mouseX < (x+w) && mouseX > x){
             if(mouseY < ( y+w) && mouseY > y){
                // code for mousepressed 
               println("button run pathplanner pressed");
               startscreen = false;
               firstperson = false;
               startpathplanner = true;
               pathplannerscreen = true;
              
                }
             }
          }
  
  
  }
  
   public void draw_configButton(int x, int y, int w, int h){
  
        fill(255);
        rect(x,y,w,h);
        fill(0);
        text("config", x+10, y+20);
        
         if (mousePressed == true ) {
           if(mouseX < (x+w) && mouseX > x){
             if(mouseY < ( y+w) && mouseY > y){
                // code for mousepressed 
               println("button run pathplanner pressed");
               startscreen = false;
               firstperson = false;
               startpathplanner = true;
              
                }
             }
          }
  
  
  }
  
  public void draw_ScenarioPlannerButton(int x, int y, int w, int h){
  
        fill(255);
        rect(x,y,w,h);
        fill(0);
        text("ScenarioPlanner", x+10, y+20);
        
         if (mousePressed == true ) {
           if(mouseX < (x+w) && mouseX > x){
             if(mouseY < ( y+w) && mouseY > y){
                // code for mousepressed 
               println("button run pathplanner pressed");
               startscreen = false;
               firstperson = false;
               //startpathplanner = true;
              
                }
             }
          }

  }
  
  
  

}
class SystemMonitor{

  int steer;
  Table table;
  
  
SystemMonitor(){

  steer = 512;
  table = new Table();
  
  table.addColumn("Serial Available");
  table.addColumn("Steer Value");
  table.addColumn("Control State");
  
  TableRow newRow = table.addRow();
  newRow.setFloat("Steer Value", steer);
  
}


public void run(int Tsteer){
    steer = Tsteer;
    println(
    "serial = " + serialavailable + "  -  " + 
    "steer = " + steer + "  -  " + 
    "controlstate = " +controlState + "  -  " + 
    "theta = " + car.getTheta() + "  -  " + 
    "Speed = " + car.getSpeed() + "  -  " + 
    "drive status = " + car.getDriveStatus() + "  -  " + 
    "Nspeed = " + car.getNettoSpeed()
    );
    
  // save to shared memory
  
  //newRow.setBoolean("Serial Available", serialavailable);
   TableRow row = table.getRow(0);
   row.setInt("Serial Available", PApplet.parseInt(serialavailable));
   row.setFloat("Steer Value", steer);
   row.setInt("Control State", controlState);
 //  row.setInt("Drive Status", int(car.getDriveStatus()));
  // row.setFloat("Netto Speed", car.getNettoSpeed());
  
  saveTable(table, "../data/sharedmemory.csv");
}




}
  public void settings() {  size(1600,800,P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--hide-stop", "Simulator" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
