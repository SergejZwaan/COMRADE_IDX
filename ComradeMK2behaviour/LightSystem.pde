class LightSystem {

  // light system variables
  PVector location, velocity, acceleration, drag;
  int size;
  String state;
  float target;
  float brightblue;
  float bright;

  LightSystem() {
    // initialize PVectors
    location = new PVector(options.locationMax/2, (height/4)-20);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    brightblue = 0.0;
  }

  void run() {
    // display sprite;
    
    calcForce();
    calcDrag();
    calcColor();
    update();
    display();
    
  }

  void display() {
    // sprite
    ellipse(location.x, location.y, 10, 10);
  }

  // newtonian update mechanism
  void update() {
    velocity.add(acceleration);
    velocity.add(drag);
    velocity.limit(3.0);
    
    location.add(velocity);
  }
  
  
  
  
  
  void calcForce(){
    acceleration = new PVector((target - location.x),0);
    acceleration.mult(options.accelerationMult);
  }
  
  void calcDrag(){
    float c = 0.02;
    PVector friction = velocity.copy();
    
    friction.mult(-1);
    friction.normalize();
    friction.mult(c);
    drag = friction.copy();
  }
  
  void calcColor(){
    if(brightblue > bright){
      brightblue -= 0.01;}
    if(brightblue < bright){
      brightblue += 0.01;}
  }



  // Return functions
  PVector get_Location() {
    return location;
  }
  int get_Size() {
    return size;
  }
  
  float get_Target_Bright_Blue(){
    return brightblue;
  }
  
  // additional functions
  void testcase() {
    if (location.x > options.locationMax || location.x < options.locationMin) {
      velocity.x *= -1;
    }
  }
  
    void Set_State(String Input){state = Input;}
    void Set_Target(float Input){target = Input;}
    void Set_Bright(float Input){bright = Input;}


}