class Car_Light
{
  
  private:
  // class variables
  float location = 40.0;
  float velocity = -0.5;

  
  float target = 10.0;
  float target2 = 50.0;
  
  int led_car = 0;
  int state = 0;
  int outputstate = 0;
  float dist;

  float animate = 1.0;
  float animate_speed = 0.5;
  
  public:
  // initialization
  Car_Light(){
    location = NUMPIXELS/2;
    
  }
  
  // running
  void execute(){
    
    update_light();
    check_edges();
    display_location();
    fill_array();
  }
  
  // functions
  void update_light(){

   
    // neutral state
    if(state == 0){
      target = 40.0;
      }

    // autonomous driving state
    if(state == 1){
      target = 10.0;
      }

    // manual driving state
    if(state == 2){
      target = 75.0;
      }

    // Autonomous state - behaviour 1, doesnt want control
    if(state == 3){
      target = 10.0;
      }

     // Autonomous state - behaviour 2, wants control
     if(state == 4){
      target = 75.0;
      }

      // Autonomous state - behaviour 3, is uncertain about the situation
      if(state == 5){
      target = 10.0;
      }

    
    // movement animation
    // move right
    if(location > target){
      location += velocity;
      }
    // move left
    if(location < target){
      location -= velocity;
      }


    // set output states
    if(state == 0){
      outputstate = 0;
    }

    if(state == 1){
      if(abs(location - 10.0)<5){
        outputstate = 1;
        }
      }

    if(state == 2){
      if(abs(75.0 - location)<5){
        outputstate = 2;
        }
      }

      
    
  }

  // free movement check edges function
  void check_edges(){

    }

  // convert location to led index
  void display_location(){
    led_car = location;
  }


  // array fill function
  void fill_array(){

        // 0, 1 , 2
        // -------------------------------------------------
           if(state == 0 || state == 1 || state == 2){
              for(int i=0;i<NUMPIXELS;i++){
                  if(i == led_car){
                    car[i] = 255;
                  }else if(i == led_car-1){
                    car[i] = 200;
                  }else if(i == led_car+1){
                    car[i] = 200;
                  }
                  else if( car[i] > 1){
                    car[i] -= 4;
                  }else{
                    car[i] = 0;
                  }
              }
           }

        // state 3
        if(state ==  3 ){
          
          car[led_car] = 255;
          animate += animate_speed;
          
          
          for( int i = 0; i < animate; i++){
              if(car[led_car + i] < 230){
              car[led_car + i] =255;
              }
            }

           if(animate > 25){
            animate = 1.0;
                for(int i=0;i<NUMPIXELS;i++){
                    if(car[i] > 100){
                    car[i] = 50;
                    } else{
                    car[i] = 0;  
                    }
                }
            }

            if(animate > 25){
            animate = 1.0;
                for(int i=0;i<NUMPIXELS;i++){
                    if(car[i] > 100){
                    car[i] = 50;
                    } else{
                    car[i] = 0;  
                    }
                }
            }
           for(int i=0;i<NUMPIXELS;i++){
            if(car[i] > 0){
                car[i] -= 5;
              }
            }
          }

          // state 4
          // -------------------------------------------------
        if(state ==  4 ){
          
          car[led_car] = 255;
          animate += animate_speed;
          
          
          for( int i = 0; i < animate; i++){
              if(car[led_car - i] < 230){
              car[led_car - i] =255;
              }
            }

           if(animate > 25){
            animate = 1.0;
                for(int i=0;i<NUMPIXELS;i++){
                    if(car[i] > 100){
                    car[i] = 50;
                    } else{
                    car[i] = 0;  
                    }
                }
            }

            if(animate < -25){
            animate = 1.0;
                for(int i=0;i<NUMPIXELS;i++){
                    if(car[i] > 100){
                    car[i] = 50;
                    } else{
                    car[i] = 0;  
                    }
                }
            }
           for(int i=0;i<NUMPIXELS;i++){
            if(car[i] > 0){
                car[i] -= 5;
              }
            }
          }

           // state 5
           // -------------------------------------------------
        if(state ==  5 ){
          
          car[led_car] = 255;
          animate += animate_speed;
          
          
          for( int i = 0; i < animate; i++){
              if(car[led_car - i] < 230){
              car[led_car - i] =255;
              }
              if(car[led_car + i] < 230){
              car[led_car + i] =255;
              }
            }

           if(animate > 10){
            animate = 1.0;
                for(int i=0;i<NUMPIXELS;i++){
                    if(car[i] > 100){
                    car[i] = 50;
                    } else{
                    car[i] = 0;  
                    }
                }
            }

           for(int i = -10; i < 20; i++){
            int r = int(random(0,3));
            if(r == 0){
              car[led_car+i] = 0;
              }
            }
           
           for(int i=0;i<NUMPIXELS;i++){
            if(car[i] > 0){
                car[i] -= 5;
              }
            }
          }
  }
  
  // return function
  
  int get_led_car(){
    //return led_car;
  }
  
  float get_led_car_velocity(){
    //return velocity;
  }

  void set_state(int input){
      state = input;
  }

  int get_state(){
      return state;
    }

  int get_output_state(){
      return outputstate;
    }

};
