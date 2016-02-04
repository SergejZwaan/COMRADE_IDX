class Driver_Light{
  
  private:
  // class variables
  float location = 0.0; // virtual light location
  float velocity = 0.5; // virtual light velocity
  
  int led_driver = 0;   // concrete led location

  boolean touchswitch = false;

  int swipeleft = 0;
  int swiperight = 0;
  
  
  public:
  Driver_Light(){

  }
  
  void execute(int sensorInput){

    // TOUCH SWITCH

        if(touch == true && touchswitch == false){
          location = sensorInput;
          touchswitch = true;
          }

        if(touch == false && touchswitch == true){
          touchswitch = false;
          }

        if(touch == false){
            swiperight = 0;
            swipeleft = 0;
          }




    // motion filter
    if(sensorInput > location){
      location += velocity;
      swipeleft++;
      swiperight = 0;
      }
    if(sensorInput < location){
      location -= velocity;
      swiperight++;
      swipeleft = 0;
      }

    // translation to array
    led_driver = location + 25;
    led_driver *= 1.4;
    fill_array();
  }
  
  void fill_array(){
    
     for(int i=0;i<NUMPIXELS;i++){
        
       if(touch && led_driver>0){
       
            if(i == led_driver && driver[i]<255){
              driver[i] += 5;
            } else if(i == led_driver-1 && driver[i]<200){
              driver[i] +=1;
            }else if(i == led_driver+1 && driver[i]<200){
              driver[i] +=1;
            }else if(i == led_driver-2 && driver[i]<100){
              driver[i] +=1;
            }else if(i == led_driver+2 && driver[i]<100){
              driver[i] +=1;
            } else if(i == led_driver+3 && driver[i]<50){
              driver[i]  +=1;
            }else if(i == led_driver+3 && driver[i]<50){
              driver[i]  +=1;
            }else if( driver[i] > 1){
              driver[i] -= 2;
            }else{
              driver[i] = 0;
            }
            
           if(driver[i] > 255){
              driver[i] = 255;
            }
       }
       
       if(touch == false){
             driver[i] =0;
            }
      }
  }
  
  int get_driver_light_filter(){
    return led_driver;
  }

  // 0 for neutral 1 for right, 2 for left
  int get_swipe(){
    int  value = 0;
    if(swiperight > 5 && swipeleft == 0){
      value = 1;
      }
    if(swiperight == 0 && swipeleft > 5){
      value = 2;
      }
    if(swiperight == 0 && swipeleft == 0){
      value = 0;
      }

    return value;
    }

};
