class Distance_Sensor{

  
  private:
  int i; // incomming data variable
  int dis; // calculated distance
  int distance; // distance shared globaly

  
  
  public:
  Distance_Sensor(){
  
  }

  // reads incomming value
  void execute(){
        i=analogRead(DISTANCEPIN);
        dis=(6762/(i-9))-4;
        // If value is between 6 and 30, the value is transmited to distance
        // Touch is then true
        touch = false;
        if(dis > 5 && dis < 20){
            distance = dis;
            touch = true;
        } else if(dis < 5  ){
            distance = 0;
            touch = false;
        } else if( dis > 20){
            distance = 0;
            touch = false;
        }

        
        
  }

  // return distance
  int get_distance(){
      return distance;
  }


};
