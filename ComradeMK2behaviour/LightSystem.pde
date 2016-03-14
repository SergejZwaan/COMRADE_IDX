class LightSystem {

  // light system variables
  PVector location, velocity, acceleration;
  int size;
  float security;


  // range setting



  LightSystem() {
    // initialize PVectors
    location = new PVector(options.locationMax/2, (height/4)-20);
    velocity = new PVector(-0.5, 0);
    acceleration = new PVector(0, 0);
  }

  void run() {

    // display sprite;
    update();
    testcase();
    display();
  }

  void display() {
    // sprite
    ellipse(location.x, location.y, 10, 10);
  }

  // newtonian update mechanism
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
  }

  void testcase() {
    if (location.x > options.locationMax || location.x < options.locationMin) {
      velocity.x *= -1;
    }
  }

  // Return functions
  PVector get_Location() {
    return location;
  }
  int get_Size() {
    return size;
  }
  float get_Security() {
    return security;
  }
}