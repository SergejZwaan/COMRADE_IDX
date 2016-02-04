class System_Monitor{
   
  private:
  int Car_Location_Monitor;
  int Driver_Location_Monitor;
  int Distance_Sensor;
  int Filter_Monitor;
  int Swipe_Monitor;
  float Pot_Monitor;
  
  public:
  System_Monitor(){

  }
  
  void execute(int led_car, int led_driver, float car_velocity, int distance, int swipe, float pot){
   
    Car_Location_Monitor = led_car;
    Driver_Location_Monitor = led_driver;
    Distance_Sensor = distance;
    Swipe_Monitor = swipe;
    Pot_Monitor = pot;
    
    // Car location
    Serial.print("CarLoc = ");
    Serial.print(Car_Location_Monitor);
    Serial.print("\t");

    // Driver location
    Serial.print("CarLoc = ");
    Serial.print(Driver_Location_Monitor);
    Serial.print("\t");

    // Distance sensor
    Serial.print("DistSens = ");
    Serial.print(Distance_Sensor); 
    Serial.print("\t");

    // Global touch variable
    Serial.print("Touch = ");
    Serial.print(touch); 
    Serial.print("\t");

     // Swipe variable
    Serial.print("Swipe = ");
    Serial.print(Swipe_Monitor); 
    Serial.print("\t");

    // Pot sensor
    Serial.print("Pot = ");
    Serial.print(Pot_Monitor); 
    Serial.print("\t");


    
    Serial.println();
  }
  
  
    
  


};
