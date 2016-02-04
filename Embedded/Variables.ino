
// Objects
Adafruit_NeoPixel pixels = Adafruit_NeoPixel(NUMPIXELS, PIN, NEO_GRB + NEO_KHZ800);
Car_Light cl; // carlight object
Driver_Light dl; // driver light object
System_Monitor sm; // monitor object for debugging
Distance_Sensor ds; // distance sensor object
Pot_Sensor ps; // potmeter sensor object
Data_Connection dc; // data connection object, for sending data to processing


void setup() {
  
   // object setup
   sm = System_Monitor();
   ds = Distance_Sensor();
   ps = Pot_Sensor();
   dc = Data_Connection();
   
   cl =  Car_Light();
   dl = Driver_Light();
   
   Serial.begin(19200);
   pinMode(DISTANCEPIN,OUTPUT);
   pinMode(STEERPIN,OUTPUT);

   // initialize neopixel
   pixels.begin(); 
   for(int i=0;i<NUMPIXELS;i++){
    
      pixels.setPixelColor(i, pixels.Color(0,0,0));
  
    }
    
   pixels.show(); // Initialize all pixels to 'off'
}

void loop() {

    // execute objects
    cl.execute();
    dl.execute(ds.get_distance());
    ds.execute();
    ps.execute();

    dc.execute(ps.get_pot(),cl.get_output_state());
    //sm.execute(cl.get_led_car(), cl.get_led_car_velocity(),ds.get_distance(),dl.get_driver_light_filter(), dl.get_swipe(), ps.get_pot());

    // main level programs
    Switch_Control();
    Array_Updater();

    // send the final result to the neopixel
    pixels.show();
}


// Update arrays to the neopixel format
void Array_Updater(){
    
    for(int i=0;i<NUMPIXELS;i++){
      pixels.setPixelColor(i, pixels.Color(0,driver[i],car[i]));
    }
}  

// state switch 
// can be replaced by a state slot machine
void Switch_Control(){
  if(dl.get_swipe() != 0){
        cl.set_state(dl.get_swipe());
    }
  }

void Set_State(int inputState){
    cl.set_state(inputState);
  }
