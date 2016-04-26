class Car{

  PVector location;
  PVector velocity;
  PVector force;
  float theta = 0;
  float angle = PI/2;
  float oldAngle = 0.0;
  float dAngle;
  
  float xold;
  float yold;
  float distx = gridWidth/2;
  float disty = gridHeight/2+100;
  float cameraX, cameraY;
  float speed = 0.5;
  
  // acceleration variables
  float acceleration = 0.01;
  float nettospeed = 0.0;

  boolean drive = false;
  
  Car(){
    location = new PVector(gridWidth/2,gridHeight/2);
    velocity = new PVector(0,-0.5);
    force = new PVector(0,0);
    xold = gridWidth/2;
    yold = gridHeight/2+100;
    // calculate inital angle for camera point
    calc_Angle();
  }
  
  
  void update(){
    // joystick control
    if(drive && joystickavailable){
      speed = js.get_Gas()*2;
      speed -= js.get_Brake()*4;
      if(speed<0){speed = 0;}
    } else {
      // else set standard speed
      speed = 0.5;
    }
    
    // speed manager
    speedControl();
   
    // update code
    if(drive == true){
     
      if(autopilot == true){velocity.add(force);}
      
      velocity.rotate(theta);
      velocity.setMag(nettospeed);
      if(drive){location.add(velocity);}
      else{location.add(new PVector(0.0,0.0));}
      
      calc_Angle();
      }
    
     
      
  }
  
  void speedControl(){
      dAngle = abs(angle - oldAngle) * 100;
      
      
      println(theta + " " + angle + " " + dAngle);
      if(joystickavailable){speed = js.get_Gas()*3;}
      else{speed = 1.0;}
        if(dAngle < 1){
       speed -= dAngle/1.7;}else{
         theta = 0.0;
       }
      
      if(nettospeed < speed){
        nettospeed += acceleration;
      } else if(nettospeed> speed){
        nettospeed -= acceleration * 2;
      }
  
  
  }
  
  void display(){

    pushMatrix();
      translate(location.x,location.y,-5);
      rotate(angle);
      //rotate(angle/10);
     //rotate(theta/10); // tODo fix
      strokeWeight(1);
      fill(255);
      stroke(0);
      rotate(PI);
   
      translate(-30, -10,0);
      if(c.get_Perspective() != "SIMULATOR"){shape(carShape,10,10);}
    popMatrix();
    
    pushMatrix();
       
         
         translate(location.x,location.y,-80);
         rotate(angle);
         if(c.get_Perspective() == "SIMULATOR"){shape(dash, 12, 38, 25, 120);}
        
    popMatrix();
    
    
  }
  
  void calc_Angle(){
      distx = location.x - (location.x - xold)*50;
      disty = location.y - (location.y - yold)*50;
     // cameraX = location.x - (location.x - xold)*70 /car.getNettoSpeed();
     // cameraY = location.y - (location.y - yold)*70 /car.getNettoSpeed();
      xold = location.x;
      yold = location.y;
      oldAngle = angle;
      angle = atan2(location.y-disty, location.x-distx);
  
  }
  
  void run(){
    keyPressed();
    keyReleased();
    if(drive && update){update();}
    display();
  }
  

  
  
 // key controll
void keyPressed() {
  if (key == CODED) {
        if (keyCode == UP) {
          drive = true;
          theta = 0.0;
         // println("eat shit");
        } else if (keyCode == DOWN) {
          theta = 0.0;
        }  else if (keyCode == LEFT){
          theta += HALF_PI/180/40;
        } else if(keyCode == RIGHT){
          theta += -HALF_PI/180/40;
        } else{
          theta = 0.0;
        }
  }

}

void setSteer(int input){
  float steerValueInput = map(input,700,1024,-HALF_PI,HALF_PI);
  theta = -steerValueInput/270;
}

void setSteerJoyStick(float input){
  float steerValueInput = input/100;
  theta = -steerValueInput/270;
}

void resetTheta(){
  theta = 0.0;
}

// set functions
void applyForce(PVector inforce){force = inforce;}
void setDriveStatus(boolean drivestatus){drive = drivestatus;}
void setSpeed(float input){speed = input;}

void reset(){
  velocity = new PVector(0.0,0.0);
  location = new PVector(0.0,0.0);
  theta = 0.0;
}

// return functions
PVector getLocation(){return location;}
float getTheta(){return theta;}
float getangle(){return angle;}
float getSpeed(){return speed;}
float getNettoSpeed(){return nettospeed;}
boolean getDriveStatus(){return drive;}
PVector getCameraLocation(){PVector cameraLocation = new PVector(cameraX, cameraY);return cameraLocation;}
}