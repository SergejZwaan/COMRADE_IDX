class Display {
  PVector ComradeLocation;
  float[] red, green, blue;
  int ledSize;
  Display() {
    ledSize = options.ledSize;
    red   = new float[ledSize];
    green = new float[ledSize];
    blue  = new float[ledSize];
  }

  void run() {
    update();
    display();
  }

  void update() {
    ComradeLocation = comrade.get_Location().copy();
  }

  void display() {
    // display led array
    for (int led = 0; led < ledSize; led++) {
      float ledlocation = float(led) * (options.locationMax / float(options.ledSize));
      
      blue[led] = abs(ComradeLocation.x - ledlocation);
      // map value from 0 to 255
      blue[led] = map(blue[led], 255.0, 0.0, options.locationMin, options.locationMax);  
      
      fill(0,0,blue[led]);
      rect(ledlocation, height/4, 10, 10);
    }
  }
}