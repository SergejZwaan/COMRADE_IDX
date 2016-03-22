class LightSystem {

  // light system variables
  PVector location, velocity, acceleration, drag;
  String state;
  float target, brightblue, brightred, targetblue, targetred, bright, colorchangespeed, velocitylimit, dragc;

  // Object initialization
  LightSystem() {
    location = new PVector(options.locationMax/2, (height/4)-20); // set location
    velocity = new PVector(0, 0); // set velocity
    acceleration = new PVector(0, 0); // set aceleration
    colorchangespeed = 0.04; // standard speed change
    brightblue = 0.0; // start blue color
    brightred = 0.0;  // start red color
    velocitylimit = 3.0;
  }

  void run() {
    calcForce();
    calcDrag();
    calcColor();
    update();
    display();
  }

  // display sprite
  void display() {
    pushMatrix();
    translate(650,200);
    ellipse(location.x, location.y, 10, 10);
    popMatrix();
  }

  // newtonian update mechanism
  void update() {
    velocity.add(acceleration);
    velocity.add(drag);
    velocity.limit(velocitylimit);
    location.add(velocity);
  }
  
 void calcForce(){
    acceleration = new PVector((target - location.x),0);
    acceleration.mult(options.accelerationMult);
  }
  
 void calcDrag(){
    PVector friction = velocity.copy();
    friction.mult(-1);
    friction.normalize();
    friction.mult(dragc);
    drag = friction.copy();
 }
  
 // Calculate the sprites color value
 // speed of change is dependant of the amount of color change needed
 void calcColor(){
    if(brightblue > targetblue){  brightblue -= (brightblue-targetblue)*colorchangespeed;  }
    if(brightblue < targetblue){  brightblue += (targetblue-brightblue)*colorchangespeed;  }
    if(brightred > targetred)  {  brightred -= (brightred-targetred)*colorchangespeed;     }
    if(brightred < targetred)  {  brightred += (targetred-brightred)*colorchangespeed;     }
 }

 // Return variable functions
 PVector get_Location() { return location; }
 float get_Bright_Blue(){return brightblue;}
 float get_Bright_Red(){return brightred;}
  
 // set variable functions
 void Set_Velocity(PVector Input){velocity = Input;}
 void Set_State(String Input){state = Input;}
 void Set_Target(float Input){target = Input;}
 void Set_Bright(float Input){bright = Input;}
 void Set_Red(float Input){brightred = Input;}
 void Set_Blue(float Input){brightblue = Input;}
 void Set_Target_Red(float Input){targetred = Input;}
 void Set_Target_Blue(float Input){targetblue = Input;}
 void Set_Color_Change_Speed(float Input){colorchangespeed = Input; }
 void Set_Velocity_Limit(float Input){velocitylimit = Input; }
 void Set_Drag(float Input){dragc = Input; }
}