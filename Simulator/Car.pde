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
  float speed = 0.5;
  
  // acceleration variables
  float acceleration = 0.005;
  float nettospeed = 0.0;
  
  
  boolean drive = false;
  
  Car(){
    location = new PVector(gridWidth/2,gridHeight/2+200);
    velocity = new PVector(0,0);
    velocity = new PVector(0,-0.1);
    force = new PVector(0,0);
    xold = location.x;
    yold = location.y;
  }
  
  
  void update(){
    
    speedControl();
    
    if(drive == true){
      if(autopilot == true){velocity.add(force);}
      velocity.rotate(theta);
      velocity.setMag(nettospeed);
      location.add(velocity);
      
      distx = location.x - (location.x - xold)*50;
      disty = location.y - (location.y - yold)*50;
      cameraX = location.x - (location.x - xold)*80 /car.getNettoSpeed();
      cameraY = location.y - (location.y - yold)*80 /car.getNettoSpeed();
      xold = location.x;
      yold = location.y;
      
      angle = atan2(location.y-disty, location.x-distx);
      
     // println(force);
    //println(velocity.y);
    }
  }
  
  void speedControl(){
  
      if(nettospeed < speed){
        nettospeed += acceleration;
      } else if(nettospeed> speed){
        nettospeed -= acceleration;
      }
  
  
  }
  
  void display(){
    rectMode(CENTER);
    ellipseMode(CENTER);
    fill(255);
    pushMatrix();
    translate(0,0,0);
    rotate(theta);
   // line(location.x,location.y,distx,disty);
    ellipse(location.x,location.y,20,20);
    //ellipse(distx,disty,10,10);
    //ellipse(cameraX,cameraY,5,5);
    popMatrix();
    
    pushMatrix();
    translate(location.x,location.y,-10);
    rotate(angle);
    strokeWeight(1);
    fill(255);
    stroke(0);
    rotate(PI);
    rect(0,0,40,20);
    //box(30,20,10);
    shape(carShape,10,10);
    popMatrix();
    rectMode(CORNER);
  }
  
  void run(){
    keyPressed();
    keyReleased();
    update();
    display();
  }
  
  
 // key controll
void keyPressed() {
  if (key == CODED) {
        if (keyCode == UP) {
          manualinput = false;
          autopilot = true;
          theta = 0.0;
          drive = true;
          p.startAutonomousDriving(autopilot);
          
          
        } else if (keyCode == DOWN) {
          theta = 0.0;
          
          
          
        }  else if (keyCode == LEFT){
          theta = HALF_PI/180/2;
        } else if(keyCode == RIGHT){
          theta = -HALF_PI/180/2;
        } else{
          theta = 0.0;
        }
  }

}

void setSteer(int input){
  float steerValueInput = map(input,700,1024,-HALF_PI,HALF_PI);
  theta = -steerValueInput/270;
}

void resetTheta(){
  theta = 0.0;
}

void keyReleased(){
 // theta = 0;
}

PVector getLocation(){
  return location;
}

PVector getCameraLocation(){
  PVector cameraLocation = new PVector(cameraX, cameraY);
  return cameraLocation;
}

void applyForce(PVector inforce){
  force = inforce;
}

boolean getDriveStatus(){
  return drive;
}

void setDriveStatus(boolean drivestatus){
    drive = drivestatus;
}

void setSpeed(float input){
    speed = input;
}

float getTheta(){
    return theta;
}

float getSpeed(){
  return speed;
}

float getNettoSpeed(){
  return nettospeed;
}


}