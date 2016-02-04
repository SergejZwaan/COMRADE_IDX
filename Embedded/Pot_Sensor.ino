class Pot_Sensor{

  
  private:
  float val = 0;

  
  
  public:
  Pot_Sensor(){
  
  }

  // reads incomming value
  void execute(){
        val=analogRead(STEERPIN);


        
        
  }

  // return distance
  float get_pot(){
      return val;
  }


};
