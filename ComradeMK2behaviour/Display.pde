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
    
    pushMatrix();
    translate(650,200);
    // display led array
    float BrightBlue = comrade.get_Bright_Blue();
    float BrightRed = comrade.get_Bright_Red();
    for (int led = 0; led < ledSize; led++) {
      float ledlocation = float(led) * (options.locationMax / float(options.ledSize));
      
      //blue[led] = abs(ComradeLocation.x - ledlocation);
      // map value from 0 to 255
     // blue[led] = map(blue[led], 0.0, BrightBlue, options.locationMin, options.locationMax);  
     
       blue[led] = BrightBlue - abs(ComradeLocation.x - ledlocation)*2;
       red[led] = BrightRed - abs(ComradeLocation.x - ledlocation)*2;
      
      fill(red[led],blue[led] ,blue[led]*1.1);
      rect(ledlocation, height/4, 10, 10);
    }
    
    rect(options.locationMax/4, height/4+20,10,10);
    rect(options.locationMax/4*3, height/4+20,10,10);
    
    popMatrix();
    
  }
}