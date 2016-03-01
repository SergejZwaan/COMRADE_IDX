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
      else{location.add(new PVector(0.0,0.0));}
      
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
  
  void speedControl(){
  
      if(nettospeed < speed){
        nettospeed += acceleration;
      } else if(nettospeed> speed){
        nettospeed -= acceleration;
      }
  
  
  }
  
  void display(){

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
  //println(theta);
}

void setSteerJoyStick(float input){
  float steerValueInput = input/100;
  theta = -steerValueInput/270;
  print(" " + theta + " ");
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