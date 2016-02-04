class Data_Connection{
   
  private:
  int steer;
  int state;
  char val;
  
  public:
  Data_Connection(){

  }

  // send data to processing
  void execute(float Tsteer, int Tstate){

    // OUTPUT DATA
    delay(25);
    
    steer = int(Tsteer);
    state = Tstate;
    Serial.print("start");
    Serial.print(steer);
    Serial.print("b");
    Serial.print(state);
    Serial.print("/n"); 
    Serial.println();

    // INPUT DATA

    if(Serial.available()){
      val = Serial.read();
      int inputValue;
      
        if(val == '0'){
          inputValue = 0;
          Set_State(inputValue);
        }

        if(val == '1'){
          inputValue = 1;
          Set_State(inputValue);
        }

        if(val == '2'){
          inputValue = 2;
          Set_State(inputValue);
        }

        if(val == '3'){
          inputValue = 3;
          Set_State(inputValue);
        }

        if(val == '4'){
          inputValue = 4;
          Set_State(inputValue);
        }

        if(val == '5'){
          inputValue = 5;
          Set_State(inputValue);
        }
      }
  }
  
};
